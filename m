Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A842C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 16:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPkLH-0005qv-Lg; Thu, 12 Jun 2025 11:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPkLG-0005qg-EK
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:59:50 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uPkLD-0003Sb-To
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:59:50 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ6cH4lc3z6K9C8;
 Thu, 12 Jun 2025 23:57:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 73B571404F9;
 Thu, 12 Jun 2025 23:59:31 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Jun 2025 17:59:30 +0200
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, <fan.ni@samsung.com>,
 <qemu-devel@nongnu.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Bowman Terry <terry.bowman@amd.com>
CC: <linuxarm@huawei.com>, <rientjes@google.com>, <dave@stgolabs.net>,
 <joshua.hahnjy@gmail.com>, <rkodsara@amd.com>, <sj@kernel.org>,
 <xuezhengchu@huawei.com>, <yiannis@zptcorp.com>, <ziy@nvidia.com>,
 <weixugc@google.com>, Bharata B Rao <bharata@amd.com>
Subject: [RFC PATCH v2 QEMU 4/4] plugins: cache: Add a hotness tracker for
 cache misses with socket connection to device emulation
Date: Thu, 12 Jun 2025 16:57:24 +0100
Message-ID: <20250612155724.1887266-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250612155724.1887266-1-Jonathan.Cameron@huawei.com>
References: <20250612155724.1887266-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.19.247]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This adds simple hotness tracker instances suitable for pairing with
the CXL HMU emulation with control and data transfer via a socket
(port 4443)

A typical command line is:
-plugin ../qemu/bin/native/contrib/plugins/libcache.so,hotness=1,\
dcachesize=8192,dassoc=4,dblksize=64,icachesize=8192,iassoc=4,\
iblksize=64,l2cachesize=32768,l2assoc=16,l2blksize=64

Most of the parameters are concerned with configuring the cache topology so
that the accesses that reach the hotness monitor (which is pretending to
be on the CXL device) reflect those that did not hit in cache. The only
hotness specific parameter is hotness=1 to turn on hotness tracking
and allow connections from consuming device emulation.

There are many approximations in this cache model but it is closer than
not modelling the caches at all. More sophisticated modeling is easy
to add but will come with a performance cost.

The hotness tracker is based on an oracle counter array (1 counter per
granual) + hotness threshold (supplied from the emulated device).
Real devices will be resource constrained and are likely to implement
either a limited number of precise counters, or an imprecise counting
method. Emulating any of these should be easy to add.

The device emulation sends an end of epoch system based on the emulated
machine idea of time. At that point entries are added to the reported
hotlist for any counters that are over the threshold set via hotness=X.
That hotlist is queried by the device side.  All configuration is
provided over the socket from the emulated CXL Hotness Monitoring unit.

RFC question: Should I split this off as a separate plugin that duplicates
all of the cache plugin logic as well as providing the hostness monitor.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

RFCv2: Bring the hotness server element into the plugin.

Still an RFC because there are more features to implement. Looking
for feedback on the overall approach.
---
 contrib/plugins/cache.c | 434 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 427 insertions(+), 7 deletions(-)

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index 56508587d3..26185c52b0 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -7,10 +7,64 @@
 
 #include <inttypes.h>
 #include <stdio.h>
+#include <unistd.h>
 #include <glib.h>
+#include <sys/socket.h>
+#include <pthread.h>
+#include <arpa/inet.h>
 
 #include <qemu-plugin.h>
 
+/* ? Where to put a header with this stuff that the CHMU and plugin need? */
+#define HOTNESS_SERVER_PORT 4443
+enum consumer_request {
+    QUERY_TAIL,
+    QUERY_HEAD,
+    SET_THRESHOLD,
+    SET_HEAD,
+    SET_HOTLIST_SIZE,
+    QUERY_HOTLIST_ENTRY,
+    SIGNAL_EPOCH_END,
+    SET_ENABLED,
+    SET_GRANUAL_SIZE, /* Granualrity of DPA blocks to track (1 << unit size) */
+    SET_HPA_BASE,
+    SET_HPA_SIZE,
+    SET_DPA_BASE,
+    SET_INTERLEAVE_WAYS,
+    SET_INTERLEAVE_WAY,
+    SET_INTERLEAVE_GRAN,
+};
+
+#define HOTNESS_NUM_RANGES 8
+struct tracking_instance {
+    /*
+     * Some checks are done first without lock and then repeated with
+     * lock to avoid contention. (TODO show that matters)
+     */
+    pthread_mutex_t lock;
+    struct tracking_range {
+        uint64_t base;
+        uint64_t size;
+        uint64_t dpa_offset;
+        uint8_t ways;
+        uint8_t way;
+        uint64_t interleave_granual;
+    } ranges[HOTNESS_NUM_RANGES];
+    uint16_t head, tail;
+    uint32_t granual_size;
+    uint16_t hotlist_length;
+    uint64_t threshold;
+    uint64_t *hotlist;
+    uint32_t *counters;
+    size_t num_counters;
+    bool enabled;
+};
+
+#define MAX_INSTANCES 16
+pthread_mutex_t instances_lock;
+static int num_tracking_instances;
+static struct tracking_instance *instances[MAX_INSTANCES] = {};
+
 #define STRTOLL(x) g_ascii_strtoll(x, NULL, 10)
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -104,6 +158,7 @@ static Cache **l2_ucaches;
 static GMutex *l1_dcache_locks;
 static GMutex *l1_icache_locks;
 static GMutex *l2_ucache_locks;
+static GMutex *socket_lock;
 
 static uint64_t l1_dmem_accesses;
 static uint64_t l1_imem_accesses;
@@ -385,6 +440,80 @@ static bool access_cache(Cache *cache, uint64_t addr)
     return false;
 }
 
+static bool match_range(struct tracking_range *range, uint64_t paddr)
+{
+    uint64_t offset;
+
+    if (!range->size ||
+        paddr < range->base ||
+        paddr >= range->base + range->size / range->ways) {
+        return false;
+    }
+    if (range->ways == 0 || range->ways == 1) { /* no interleave */
+        return true;
+    }
+
+    /* Offset in granuals */
+    offset = (paddr - range->base) / range->interleave_granual;
+    if (offset % range->ways != range->way) {
+        return false;
+    }
+    return true;
+}
+
+/* Under instance lock */
+static void notify_tracker(struct tracking_instance *inst, uint64_t paddr)
+{
+    uint64_t offset;
+    int i;
+
+    /*
+     * This check may be wrong if racing with enabled, but
+     * we don't use the data until we have the lock and recheck.
+     * If we drop an access due to a race on an enable/disable/enable
+     * then meh.
+     */
+    for (i = 0; i < HOTNESS_NUM_RANGES; i++) {
+        if (!match_range(&inst->ranges[i], paddr)) {
+            continue;
+        }
+        break;
+    }
+    if (i == HOTNESS_NUM_RANGES) {
+        return;
+    }
+
+    pthread_mutex_lock(&inst->lock);
+    /* recheck under the lock */
+    if (!inst->enabled || !inst->counters ||
+        !match_range(&inst->ranges[i], paddr)) {
+        goto err;
+    }
+
+    offset = (paddr - inst->ranges[i].base + inst->ranges[i].dpa_offset) /
+        (inst->granual_size * inst->ranges[i].ways);
+
+    /*  TODO - check masking */
+    if (offset >= inst->num_counters) {
+        fprintf(stderr, "Out of range? %lx %lx\n", offset, inst->num_counters);
+        goto err;
+    }
+    inst->counters[offset]++;
+ err:
+    pthread_mutex_unlock(&inst->lock);
+}
+
+static void miss(uint64_t paddr)
+{
+    int i;
+
+    for (i = 0; i < num_tracking_instances; i++) {
+        if (instances[i]->enabled) {
+            notify_tracker(instances[i], paddr);
+        }
+    }
+}
+
 static void vcpu_mem_access(unsigned int vcpu_index, qemu_plugin_meminfo_t info,
                             uint64_t vaddr, void *userdata)
 {
@@ -395,9 +524,6 @@ static void vcpu_mem_access(unsigned int vcpu_index, qemu_plugin_meminfo_t info,
     bool hit_in_l1;
 
     hwaddr = qemu_plugin_get_hwaddr(info, vaddr);
-    if (hwaddr && qemu_plugin_hwaddr_is_io(hwaddr)) {
-        return;
-    }
 
     effective_addr = hwaddr ? qemu_plugin_hwaddr_phys_addr(hwaddr) : vaddr;
     cache_idx = vcpu_index % cores;
@@ -412,7 +538,11 @@ static void vcpu_mem_access(unsigned int vcpu_index, qemu_plugin_meminfo_t info,
     l1_dcaches[cache_idx]->accesses++;
     g_mutex_unlock(&l1_dcache_locks[cache_idx]);
 
-    if (hit_in_l1 || !use_l2) {
+    if (hit_in_l1) {
+        return;
+    }
+    if (!use_l2) {
+        miss(effective_addr);
         /* No need to access L2 */
         return;
     }
@@ -422,6 +552,7 @@ static void vcpu_mem_access(unsigned int vcpu_index, qemu_plugin_meminfo_t info,
         insn = userdata;
         __atomic_fetch_add(&insn->l2_misses, 1, __ATOMIC_SEQ_CST);
         l2_ucaches[cache_idx]->misses++;
+        miss(effective_addr);
     }
     l2_ucaches[cache_idx]->accesses++;
     g_mutex_unlock(&l2_ucache_locks[cache_idx]);
@@ -447,8 +578,12 @@ static void vcpu_insn_exec(unsigned int vcpu_index, void *userdata)
     l1_icaches[cache_idx]->accesses++;
     g_mutex_unlock(&l1_icache_locks[cache_idx]);
 
-    if (hit_in_l1 || !use_l2) {
-        /* No need to access L2 */
+    if (hit_in_l1) {
+        return;
+    }
+
+    if (!use_l2) {
+        miss(insn_addr);
         return;
     }
 
@@ -735,15 +870,286 @@ static void policy_init(void)
     }
 }
 
+static int register_tracker(struct tracking_instance *inst)
+{
+    pthread_mutex_lock(&instances_lock);
+    if (num_tracking_instances >= MAX_INSTANCES) {
+        pthread_mutex_unlock(&instances_lock);
+        return -1;
+    }
+    instances[num_tracking_instances++] = inst;
+    pthread_mutex_unlock(&instances_lock);
+
+    return 0;
+}
+
+/* Per hotness monitoring unit thread */
+static void *consumer_innerloop(void *_socket)
+{
+    int socket = *(int *)_socket;
+    struct tracking_instance inst = {};
+    /* Instance, command, parameter, parameter2 */
+    uint64_t paddr[4];
+    int rc;
+
+    pthread_mutex_init(&inst.lock, NULL);
+
+    /* For now only handle a single instance per block */
+    rc = register_tracker(&inst);
+    if (rc) {
+        fprintf(stderr, "Failed to register tracker\n");
+        return NULL;
+    }
+
+    while (1) {
+        uint64_t reply, param, param2;
+        enum consumer_request request;
+
+        rc = read(socket, paddr, sizeof(paddr));
+        if (rc < sizeof(paddr)) {
+            fprintf(stderr, "short message %x\n", rc);
+            continue;
+        }
+        if (paddr[0] > 0) {
+            fprintf(stderr, "Instance out of range\n");
+            continue;
+        }
+        request = paddr[1];
+        param = paddr[2];
+        param2 = paddr[3];
+
+        pthread_mutex_lock(&inst.lock);
+        switch (request) {
+        case QUERY_TAIL:
+            reply = inst.tail;
+            break;
+        case QUERY_HEAD:
+            reply = inst.head;
+            break;
+        case SET_HEAD:
+            reply = param;
+            inst.head = param;
+            break;
+        case SET_HOTLIST_SIZE: {
+            uint64_t *newlist;
+
+            reply = param;
+            inst.hotlist_length = param;
+            newlist = realloc(inst.hotlist, sizeof(*inst.hotlist) * param);
+            if (!newlist) {
+                fprintf(stderr, "failed to allocate hotlist\n");
+                break;
+            }
+            inst.hotlist = newlist;
+            break;
+        }
+        case QUERY_HOTLIST_ENTRY:
+            if (param >= inst.hotlist_length) {
+                fprintf(stderr, "out of range hotlist read?\n");
+                break;
+            }
+            reply = inst.hotlist[param];
+            break;
+        case SIGNAL_EPOCH_END: {
+            int space;
+            int added = 0;
+            int max = 0;
+
+            reply = param;
+
+            /* Head is read location, tail write */
+            /* If the rdad location is after the tail then gap */
+            if (inst.head > inst.tail) {
+                space = inst.head - inst.tail - 1;
+            } else {
+                space = inst.hotlist_length - inst.tail + inst.head - 1;
+            }
+            printf("Epoch end, space %d given %d %d %d\n",
+                   space, inst.hotlist_length, inst.head, inst.tail);
+            if (!inst.counters) {
+                fprintf(stderr,
+                        "How did we reach end of an epoque without counters?\n");
+                break;
+            }
+            for (int i = 0; i < inst.num_counters; i++) {
+                /*
+                 * This helps tune tests - unfortunately no such thing in the
+                 * CXL spec
+                 */
+                if (inst.counters[i] > max) {
+                    max = inst.counters[i];
+                }
+                if (!(inst.counters[i] > inst.threshold)) {
+                    continue;
+                }
+                inst.hotlist[inst.tail] = (uint64_t)inst.counters[i] |
+                    ((uint64_t)i << 32);
+                inst.tail = (inst.tail + 1) % inst.hotlist_length;
+                added++;
+                if (added == space) {
+                    break;
+                }
+            }
+            memset(inst.counters, 0,
+                   inst.num_counters * sizeof(*inst.counters));
+
+            printf("End of epoch %u %u %d\n", inst.head, inst.tail, max);
+            break;
+        }
+        case SET_ENABLED:
+            reply = param;
+            if (param && !inst.enabled) {
+                uint32_t *new_counters;
+                uint32_t num_counters;
+                uint64_t full_range = 0;
+                int i;
+
+                for (i = 0; i < HOTNESS_NUM_RANGES; i++) {
+                    uint64_t end;
+
+                    /* Skip disabled ranges */
+                    if (inst.ranges[i].size == 0 || inst.ranges[i].ways == 0) {
+                        continue;
+                    }
+                    end = inst.ranges[i].dpa_offset +
+                        inst.ranges[i].size / inst.ranges[i].ways;
+                    if (end > full_range) {
+                        full_range = end;
+                    }
+                }
+                num_counters = full_range / inst.granual_size;
+                new_counters = realloc(inst.counters,
+                                      sizeof(*inst.counters) * num_counters);
+                if (!new_counters) {
+                    fprintf(stderr, "Failed to allocate counter storage\n");
+                    break;
+                }
+                inst.counters = new_counters;
+                inst.num_counters = num_counters;
+            }
+            inst.enabled = !!param;
+            break;
+        case SET_THRESHOLD:
+            reply = param;
+            if (!inst.enabled) {
+                inst.threshold = param;
+            }
+            break;
+        case SET_GRANUAL_SIZE:
+            reply = param;
+            if (!inst.enabled) {
+                inst.granual_size = param;
+            }
+            break;
+        case SET_HPA_BASE:
+            reply = param;
+            if (!inst.enabled) {
+                inst.ranges[param2].base = param;
+            }
+            break;
+        case SET_HPA_SIZE:
+            reply = param;
+            if (!inst.enabled) {
+                inst.ranges[param2].size = param;
+            }
+            break;
+        case SET_DPA_BASE:
+            reply = param;
+            if (!inst.enabled) {
+                inst.ranges[param2].dpa_offset = param;
+            }
+            break;
+        case SET_INTERLEAVE_WAYS:
+            reply = param;
+            if (!inst.enabled) {
+                inst.ranges[param2].ways = param;
+            }
+            break;
+        case SET_INTERLEAVE_WAY:
+            reply = param;
+            if (!inst.enabled) {
+                inst.ranges[param2].way = param;
+            }
+            break;
+        case SET_INTERLEAVE_GRAN:
+            reply = param;
+            if (!inst.enabled) {
+                inst.ranges[param2].interleave_granual = param;
+            }
+            break;
+        default:
+            fprintf(stderr, "Unexpected command to hotness monitor\n");
+            break;
+        }
+        rc = write(socket, &reply, sizeof(reply));
+        if (rc < 0) {
+            fprintf(stderr, "write failed - muddle on\n");
+        } else if (rc != sizeof(reply)) {
+            fprintf(stderr, "partial write? %d\n", rc);
+        }
+        pthread_mutex_unlock(&inst.lock);
+    }
+}
+
+/* Outer thread that is responsible for spinning off individual server thread */
+static void *hotness_serverloop(void *private)
+{
+    int server_fd, new_socket;
+    int opt = 1;
+    struct sockaddr_in address;
+    socklen_t addrlen = sizeof(address);
+    int rc;
+
+    server_fd = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+    if (server_fd == 0) {
+        return NULL;
+    }
+
+    if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT,
+                   &opt, sizeof(opt))) {
+        return NULL;
+    }
+
+    address.sin_family = AF_INET;
+    address.sin_addr.s_addr = INADDR_ANY;
+    address.sin_port = htons(HOTNESS_SERVER_PORT);
+
+    rc = bind(server_fd, (struct sockaddr *)&address, sizeof(address));
+    if (rc < 0) {
+        return NULL;
+    }
+
+    if (listen(server_fd, 3) < 0) {
+        return NULL;
+    }
+
+    while (1) {
+        pthread_t thread;
+
+        new_socket = accept(server_fd, (struct sockaddr *)&address, &addrlen);
+        if (new_socket < 0) {
+            return NULL;
+        }
+
+        if (pthread_create(&thread, NULL, consumer_innerloop, &new_socket)) {
+            fprintf(stderr, "thread create fail\n");
+            return NULL;
+        }
+    }
+
+    return NULL;
+}
+
 QEMU_PLUGIN_EXPORT
 int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                         int argc, char **argv)
 {
-    int i;
+    int i, hotness;
     int l1_iassoc, l1_iblksize, l1_icachesize;
     int l1_dassoc, l1_dblksize, l1_dcachesize;
     int l2_assoc, l2_blksize, l2_cachesize;
 
+    hotness = 0; /* No hotness server */
     limit = 32;
     sys = info->system_emulation;
 
@@ -808,6 +1214,8 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
                 fprintf(stderr, "invalid eviction policy: %s\n", opt);
                 return -1;
             }
+        } else if (g_strcmp0(tokens[0], "hotness") == 0) {
+            hotness = STRTOLL(tokens[1]);
         } else {
             fprintf(stderr, "option parsing failed: %s\n", opt);
             return -1;
@@ -840,6 +1248,8 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
         return -1;
     }
 
+    socket_lock = g_new0(GMutex, 1);
+
     l1_dcache_locks = g_new0(GMutex, cores);
     l1_icache_locks = g_new0(GMutex, cores);
     l2_ucache_locks = use_l2 ? g_new0(GMutex, cores) : NULL;
@@ -849,5 +1259,15 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
 
     miss_ht = g_hash_table_new_full(g_int64_hash, g_int64_equal, NULL, insn_free);
 
+    if (hotness) {
+        pthread_t server_thread;
+
+        pthread_mutex_init(&instances_lock, NULL);
+        if (pthread_create(&server_thread, NULL, hotness_serverloop, NULL)) {
+            fprintf(stderr, "Hotness server failed\n");
+            return -1;
+        }
+    }
+
     return 0;
 }
-- 
2.48.1


