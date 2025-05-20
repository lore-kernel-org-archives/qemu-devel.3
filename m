Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D4CC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 14:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNm6-0004wf-Mo; Tue, 20 May 2025 10:16:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHNm5-0004uh-Eo
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:16:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uHNm3-0001DS-Bk
 for qemu-devel@nongnu.org; Tue, 20 May 2025 10:16:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43ea40a6e98so59448355e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 07:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747750613; x=1748355413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CInEGsOLz25mjMs6YRA78p9qw90h7ZdMHZE0ctttrwU=;
 b=ftqA6JHtLhsz2QJBWUzeSYFPtah3xsVvXsaxqBaHnJdIoLdMoTb8avwfXcIGmkAWzN
 GUBOTJTnypJ6Q2lWtHaGJlI4X/fifm1sCf/gfuJsGsPmH4qzjGUdLSFhDPkT4fG4YqmQ
 JG0O5YHNExljup9Uy/nlxI4WavEELDz49DBp5NyRzwftM6h2Vw0GMNo2tI1CbH8u3FjU
 0FAgtXKG3Xu4GtxMAfHPG3akpy92eqLatEEkG5PV3LLUKwXZ7ELHJ5v9JdIV19rFASCh
 aFI7y+2MTzEUXRvfF69l3HyStieHMaGUXM32Q4og2auNqEgNX4+DfsqT8kCt2oZQdvWh
 zN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747750613; x=1748355413;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CInEGsOLz25mjMs6YRA78p9qw90h7ZdMHZE0ctttrwU=;
 b=AVNvAd2hunsp02Xn+kqmPrvmtqWfvnmxdBILwZm/EMQ/1FtF+VFvD4dbiwSTW+YT6s
 NgXehXGf0WnEFZ22l5/SjbjjcYM9R2Fr3mVyxc1+umOydO/efm3Hv4FYD8KVq0OHK6sq
 owU3qMWRi5atHLJEOupeusVTBR3iRs8SwOLIObhK8F8lF4JDI+4DtJVg53sReDa42SKM
 duMy88nGN7aZoP+DUH/eeKvCuwakmn2C/dBkJ6Ks/urDq4Av7Gr4gCUJLAbKB8h3w4hZ
 9IFk+JJsr4CwJEQ6Ip6MTrY93YNJRzdvvOVyko/Elb+4BGX1ZtM6paDfMNK8GJt06GeX
 QtVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQZaPAS6VMh+bzCE2f8dXKTmFmv8n2TuATLjh0uxHQJIOI7YfGm2455L84erlssNF/R8LwnlzCcnfF@nongnu.org
X-Gm-Message-State: AOJu0Yxnxn1Qd3Xz4sfSPG4dz0nJUDGrhIN8/fI4fN2ugwV/+pzHKvAE
 wD8AeFDmGlty7jGkM687MPUzDobUaz79ClI5k3lG4qQbcEa9a4/teHZmOzabEDyeiEg=
X-Gm-Gg: ASbGncv8nsv83BGHSSKeHX4unBtuDqKKb60KclCu8YiA0+a9MmzGKFtU3L0wgJfwui5
 HN9VXYCoqGg0t17QBySEmwMZpu8lPS0dTukut6lSLsIsGu0kuNJ38OGfX+rBSIjRo9RePhYa53e
 v+U1UGXn4hY/9SvbjrLlgS8ZkjogZ5IQs9pcYapXzm1butnrn0xRwewXrkYDueNmXX8AjMQ6vKR
 6LsYizk0VtdQGvdmkj3ISvYxAPpo8Rc6MmCFnvpfYVi3RCACRW+NPhwwm4E8ZHE8O7H5IapCww5
 E2U/J/ik6aOPbdcTppX+Hba25fNM+Sr0FO8CwGGQ3LYPgMJ3vc18
X-Google-Smtp-Source: AGHT+IHyqae4al0WhGqWVoe23MBDbSjMoqgbacwPgIiLS45edaSa3sgI2O1OQM1X/goV9Fj18sto1A==
X-Received: by 2002:a05:6000:3111:b0:3a3:7d7f:47bf with SMTP id
 ffacd0b85a97d-3a37d7f4827mr492589f8f.4.1747750613368; 
 Tue, 20 May 2025 07:16:53 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca5abaesm16638636f8f.39.2025.05.20.07.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 07:16:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC9E35F7A5;
 Tue, 20 May 2025 15:16:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <fan.ni@samsung.com>,  <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>,  Alexandre Iooss <erdnaxe@crans.org>,  Mahmoud
 Mandour <ma.mandourr@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  <linuxarm@huawei.com>,  Niyas Sait
 <niyas.sait@huawei.com>
Subject: Re: [RFC PATCH QEMU 2/3] plugins: Add cache miss reporting over a
 socket.
In-Reply-To: <20250124172905.84099-3-Jonathan.Cameron@huawei.com> (Jonathan
 Cameron's message of "Fri, 24 Jan 2025 17:29:04 +0000")
References: <20250124172905.84099-1-Jonathan.Cameron@huawei.com>
 <20250124172905.84099-3-Jonathan.Cameron@huawei.com>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Tue, 20 May 2025 15:16:51 +0100
Message-ID: <87zff79xkc.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> This allows an external program to act as a hotness tracker.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  contrib/plugins/cache.c | 75 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 68 insertions(+), 7 deletions(-)
>
> diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
> index 7baff86860..5af1e6559c 100644
> --- a/contrib/plugins/cache.c
> +++ b/contrib/plugins/cache.c
> @@ -7,10 +7,17 @@
>=20=20
>  #include <inttypes.h>
>  #include <stdio.h>
> +#include <unistd.h>
>  #include <glib.h>
> +#include <sys/socket.h>
> +#include <arpa/inet.h>
>=20=20
>  #include <qemu-plugin.h>
>=20=20
> +static int client_socket =3D -1;
> +static uint64_t missfilterbase;
> +static uint64_t missfiltersize;
> +
>  #define STRTOLL(x) g_ascii_strtoll(x, NULL, 10)
>=20=20
>  QEMU_PLUGIN_EXPORT int qemu_plugin_version =3D QEMU_PLUGIN_VERSION;
> @@ -104,6 +111,7 @@ static Cache **l2_ucaches;
>  static GMutex *l1_dcache_locks;
>  static GMutex *l1_icache_locks;
>  static GMutex *l2_ucache_locks;
> +static GMutex *socket_lock;
>=20=20
>  static uint64_t l1_dmem_accesses;
>  static uint64_t l1_imem_accesses;
> @@ -385,6 +393,21 @@ static bool access_cache(Cache *cache, uint64_t addr)
>      return false;
>  }
>=20=20
> +static void miss(uint64_t paddr)
> +{
> +    if (client_socket < 0) {
> +        return;
> +    }
> +
> +    if (paddr < missfilterbase || paddr >=3D missfilterbase + missfilter=
size) {
> +        return;
> +    }
> +
> +    g_mutex_lock(socket_lock);
> +    send(client_socket, &paddr, sizeof(paddr), 0);
> +    g_mutex_unlock(socket_lock);
> +}
> +
>  static void vcpu_mem_access(unsigned int vcpu_index, qemu_plugin_meminfo=
_t info,
>                              uint64_t vaddr, void *userdata)
>  {
> @@ -395,9 +418,6 @@ static void vcpu_mem_access(unsigned int vcpu_index, =
qemu_plugin_meminfo_t info,
>      bool hit_in_l1;
>=20=20
>      hwaddr =3D qemu_plugin_get_hwaddr(info, vaddr);
> -    if (hwaddr && qemu_plugin_hwaddr_is_io(hwaddr)) {
> -        return;
> -    }
>=20=20
>      effective_addr =3D hwaddr ? qemu_plugin_hwaddr_phys_addr(hwaddr) : v=
addr;
>      cache_idx =3D vcpu_index % cores;
> @@ -412,7 +432,11 @@ static void vcpu_mem_access(unsigned int vcpu_index,=
 qemu_plugin_meminfo_t info,
>      l1_dcaches[cache_idx]->accesses++;
>      g_mutex_unlock(&l1_dcache_locks[cache_idx]);
>=20=20
> -    if (hit_in_l1 || !use_l2) {
> +    if (hit_in_l1) {
> +        return;
> +    }
> +    if (!use_l2) {
> +        miss(effective_addr);
>          /* No need to access L2 */
>          return;
>      }
> @@ -422,6 +446,7 @@ static void vcpu_mem_access(unsigned int vcpu_index, =
qemu_plugin_meminfo_t info,
>          insn =3D userdata;
>          __atomic_fetch_add(&insn->l2_misses, 1, __ATOMIC_SEQ_CST);
>          l2_ucaches[cache_idx]->misses++;
> +        miss(effective_addr);
>      }
>      l2_ucaches[cache_idx]->accesses++;
>      g_mutex_unlock(&l2_ucache_locks[cache_idx]);
> @@ -447,8 +472,12 @@ static void vcpu_insn_exec(unsigned int vcpu_index, =
void *userdata)
>      l1_icaches[cache_idx]->accesses++;
>      g_mutex_unlock(&l1_icache_locks[cache_idx]);
>=20=20
> -    if (hit_in_l1 || !use_l2) {
> -        /* No need to access L2 */
> +    if (hit_in_l1) {
> +        return;
> +    }
> +
> +    if (!use_l2) {
> +        miss(insn_addr);
>          return;
>      }
>=20=20
> @@ -739,14 +768,16 @@ QEMU_PLUGIN_EXPORT
>  int qemu_plugin_install(qemu_plugin_id_t id, const qemu_info_t *info,
>                          int argc, char **argv)
>  {
> -    int i;
> +    int i, port;
>      int l1_iassoc, l1_iblksize, l1_icachesize;
>      int l1_dassoc, l1_dblksize, l1_dcachesize;
>      int l2_assoc, l2_blksize, l2_cachesize;
> +    struct sockaddr_in server_addr;
>=20=20
>      limit =3D 32;
>      sys =3D info->system_emulation;
>=20=20
> +    port =3D -1;
>      l1_dassoc =3D 8;
>      l1_dblksize =3D 64;
>      l1_dcachesize =3D l1_dblksize * l1_dassoc * 32;
> @@ -808,11 +839,39 @@ int qemu_plugin_install(qemu_plugin_id_t id, const =
qemu_info_t *info,
>                  fprintf(stderr, "invalid eviction policy: %s\n", opt);
>                  return -1;
>              }
> +        } else if (g_strcmp0(tokens[0], "port") =3D=3D 0) {
> +            port =3D STRTOLL(tokens[1]);
> +        } else if (g_strcmp0(tokens[0], "missfilterbase") =3D=3D 0) {
> +            missfilterbase =3D STRTOLL(tokens[1]);
> +        } else if (g_strcmp0(tokens[0], "missfiltersize") =3D=3D 0) {
> +            missfiltersize =3D STRTOLL(tokens[1]);
>          } else {
>              fprintf(stderr, "option parsing failed: %s\n", opt);
>              return -1;
>          }
>      }
> +    if (port >=3D -1) {
> +        uint64_t paddr =3D 42; /* hello, I'm a provider */
> +        client_socket =3D socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
> +        if (client_socket < 0) {
> +            printf("failed to create a socket\n");
> +            return -1;
> +        }
> +        printf("Cache miss reported on on %lx size %lx\n",
> +               missfilterbase, missfiltersize);
> +        memset((char *)&server_addr, 0, sizeof(server_addr));
> +        server_addr.sin_family =3D AF_INET;
> +        server_addr.sin_addr.s_addr =3D htonl(INADDR_LOOPBACK);
> +        server_addr.sin_port =3D htons(port);
> +
> +        if (connect(client_socket, (struct sockaddr *)&server_addr,
> +                    sizeof(server_addr)) < 0) {
> +            close(client_socket);
> +            return -1;
> +        }
> +        /* Let it know we are a data provider */
> +        send(client_socket, &paddr, sizeof(paddr), 0);
> +    }

No particular objections to the patch as is. I do wonder if it would be
worth exposing a chardev pipe to plugins so we could take advantage of
QEMU's flexible redirection handling.

But not a blocker for this.

>=20=20
>      policy_init();
>=20=20
> @@ -840,6 +899,8 @@ int qemu_plugin_install(qemu_plugin_id_t id, const qe=
mu_info_t *info,
>          return -1;
>      }
>=20=20
> +    socket_lock =3D g_new0(GMutex, 1);
> +
>      l1_dcache_locks =3D g_new0(GMutex, cores);
>      l1_icache_locks =3D g_new0(GMutex, cores);
>      l2_ucache_locks =3D use_l2 ? g_new0(GMutex, cores) : NULL;

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

