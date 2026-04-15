Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A218CF433CD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 21:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD8Df-0002O6-Ds; Wed, 15 Apr 2026 17:56:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8DW-0002LM-Mv
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:56:15 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8DT-0002lJ-KH
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:56:14 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so96977495e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776290169; x=1776894969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SbzRYXXryYZ+mwGu76PWqGXVlNyCIhPPUDzA8n+lP6I=;
 b=izI+MYoJthDgTj44brPRhQa+liqJvitMw8GBXLbPFV8PQ+nFHWFIQSL46YFnDHnZIj
 VKpXUI7zEU/N+10hQPdO/bP01SbgofIbhxVAQMtg1fsPd0A9YCjqgbhnxtmbgvB8jqBT
 gUWCXOy8aOTCimwRMuZeo4yoXKcWTLjMCIu7vBdv1kc3kxS2xmzj9mfLNnkpBKFb/jyc
 fdjlyiyfz78Yv+vf0nz7T6a+l7pkv7I+69P3pIfW1dZf2J3yH5RWL9kXlSSvfzYjaLRO
 Ium8NgZdoYD3r4qjEhXzx1fuwdAf2/pmnEk+zgyReUdE1xmfQ78WsHt0Jl2Kts0TVvwT
 CWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776290169; x=1776894969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SbzRYXXryYZ+mwGu76PWqGXVlNyCIhPPUDzA8n+lP6I=;
 b=fge3HXQgGziO7CFFrTawtBv5z9LyCN/lOUyW6e93Ste2h2N1HD4OgASONOjU90I7g4
 ZlV04wRFK/EjtBbTbS70xHlfA/BecLKRrLuhIw+jGHRxmyeuGz7sudOmR7cHn3fD2Gss
 9Btyv0CtCxO7bRq+pHwAXTBdUdaTPRpQ4NgfIylfH2QtcKLVImZWIAOOKw5NbqtoPaGU
 4BEmXSZG+t+Cz+mwPPOU6d1TjuLmNvnY2xjanLCvD0BPHkkfe0fillYyRsjAdBO0JKfB
 feJERBvjaCKx1GW5z+jPQ2vhau5iDqSOQsmNUVBbLRit3Zz1G/FkKJukfQX29PDIRtTI
 7zbQ==
X-Gm-Message-State: AOJu0YwAqylBevh5kxIJe0bVvYCumHmoH6agBlrdti+PEYIqegOlY8ti
 46CJKqPU+UsAWsNCkxLE21yI+H163k9ls+uHfOG3b4BuOC22F+xodlI02RC9tu947Uq51e34Jd3
 RvRggnOY=
X-Gm-Gg: AeBDietiZp6c/2KFtGb6v+piVhXIahsvXS+LNV+8SpCk+p/F5ygaJ13V99R/O/kjIrQ
 HWvQHivyU/wj3xn/T95PGMrGTy79cHcZeM6uo9JeueXINK5gQ3/g2q4aoa6/vBW6GiocvnjqEVL
 s/U/XM0EBMlCBd04wEhK3vOQe5kjNiFp/nIcLutge5nn9MBazEZXKOVk+YO0tA0FwSkC2Q3HKMm
 NDWNDAzUi5/zmL/ZIWwKIwUIetoK9oTzgUqF6R6FIEsRZCpTyKKwpU2/htzF/LFi+0qutVtaPPG
 2R66Jcqsh+D81ucPi87nKYOnLWnqatVr2ANlIEBhIpdShLfjXBilsnq7//rQRMfoGxtWORY5Ztd
 yu7NZS+Etv5+6YOvbEpi2urrxLSWKxSUyWOc7pgz5BEzXj8hO0ktK5SGtFw/2ChJgh89hLYX9cP
 Wfetlv/Zju0WP+BIPBj4D+LHXo8+ZDLhzt6+SDYuaqdPZbj51uFnN7W6HCmGf4TK9MmkuLs7xf
X-Received: by 2002:a05:600c:348d:b0:486:ff92:63e5 with SMTP id
 5b1f17b1804b1-488d67df5aamr346175875e9.6.1776290168733; 
 Wed, 15 Apr 2026 14:56:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f584e243sm261015e9.10.2026.04.15.14.56.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 14:56:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH 4/8] cocci: Do not initialize variable used by QTAILQ_FOREACH
 macro
Date: Wed, 15 Apr 2026 23:55:35 +0200
Message-ID: <20260415215539.92629-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415215539.92629-1-philmd@linaro.org>
References: <20260415215539.92629-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The QTAILQ_FOREACH() macro, defined in "qemu/queue.h",
always assigns its iterator variable when entering the
loop. Remove the pointless and possibly misleading
assignment.

Mechanical patch using the following coccinelle spatch:

  @@
  type T;
  identifier e;
  iterator FOREACH_MACRO =~ ".*_FOREACH.*";
  statement S;
  @@
  -    T *e = ...;
  +    T *e;
       ... when != e
       FOREACH_MACRO(e, ...) S

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/spapr.c                   | 2 +-
 hw/ppc/spapr_events.c            | 4 ++--
 net/colo-compare.c               | 4 ++--
 net/net.c                        | 2 +-
 target/s390x/kvm/stsi-topology.c | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0ab39dfea6b..bc7232e774a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3685,7 +3685,7 @@ struct SpaprDimmState {
 static SpaprDimmState *spapr_pending_dimm_unplugs_find(SpaprMachineState *s,
                                                        PCDIMMDevice *dimm)
 {
-    SpaprDimmState *dimm_state = NULL;
+    SpaprDimmState *dimm_state;
 
     QTAILQ_FOREACH(dimm_state, &s->pending_dimm_unplugs, next) {
         if (dimm_state->dimm == dimm) {
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 1a21ac7bbf8..ab23e3f477b 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -460,7 +460,7 @@ static void rtas_event_log_queue(SpaprMachineState *spapr,
 static SpaprEventLogEntry *rtas_event_log_dequeue(SpaprMachineState *spapr,
                                                   uint32_t event_mask)
 {
-    SpaprEventLogEntry *entry = NULL;
+    SpaprEventLogEntry *entry;
 
     QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
         const SpaprEventSource *source =
@@ -482,7 +482,7 @@ static SpaprEventLogEntry *rtas_event_log_dequeue(SpaprMachineState *spapr,
 
 static bool rtas_event_log_contains(SpaprMachineState *spapr, uint32_t event_mask)
 {
-    SpaprEventLogEntry *entry = NULL;
+    SpaprEventLogEntry *entry;
 
     QTAILQ_FOREACH(entry, &spapr->pending_events, next) {
         const SpaprEventSource *source =
diff --git a/net/colo-compare.c b/net/colo-compare.c
index c356419d6a8..abc1326b704 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1396,7 +1396,7 @@ static void colo_compare_init(Object *obj)
 
 void colo_compare_cleanup(void)
 {
-    CompareState *tmp = NULL;
+    CompareState *tmp;
     CompareState *n = NULL;
 
     QTAILQ_FOREACH_SAFE(tmp, &net_compares, next, n) {
@@ -1407,7 +1407,7 @@ void colo_compare_cleanup(void)
 static void colo_compare_finalize(Object *obj)
 {
     CompareState *s = COLO_COMPARE(obj);
-    CompareState *tmp = NULL;
+    CompareState *tmp;
 
     qemu_mutex_lock(&colo_compare_mutex);
     QTAILQ_FOREACH(tmp, &net_compares, next) {
diff --git a/net/net.c b/net/net.c
index a176936f9bc..2892f1730d1 100644
--- a/net/net.c
+++ b/net/net.c
@@ -653,7 +653,7 @@ static ssize_t filter_receive_iov(NetClientState *nc,
                                   NetPacketSent *sent_cb)
 {
     ssize_t ret = 0;
-    NetFilterState *nf = NULL;
+    NetFilterState *nf;
 
     if (direction == NET_FILTER_DIRECTION_TX) {
         QTAILQ_FOREACH(nf, &nc->filters, next) {
diff --git a/target/s390x/kvm/stsi-topology.c b/target/s390x/kvm/stsi-topology.c
index c8d6389cd87..301d41b68d2 100644
--- a/target/s390x/kvm/stsi-topology.c
+++ b/target/s390x/kvm/stsi-topology.c
@@ -285,7 +285,7 @@ static void s390_topology_fill_list_sorted(S390TopologyList *topology_list)
  */
 static void s390_topology_empty_list(S390TopologyList *topology_list)
 {
-    S390TopologyEntry *entry = NULL;
+    S390TopologyEntry *entry;
     S390TopologyEntry *tmp = NULL;
 
     QTAILQ_FOREACH_SAFE(entry, topology_list, next, tmp) {
-- 
2.53.0


