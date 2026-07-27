Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 248B9C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woLQK-0003Nm-21; Mon, 27 Jul 2026 09:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woLQ7-0003LL-8r
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woLQ4-0002gC-4B
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 09:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785159058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=AX7jsT9/zf/KqAg/8uhcqRDbZH5TTxg1c6I0SRHtYO0=;
 b=BfssA9zID7mS84jxZopAp6TcT/XDO1KubEO6fta0tZ3OHNA78/jErpNYkGHwbmP+Np6hR+
 3jaTcg+oWkPbk0a2iR9RL2IPTGROyms7vnRJl4cLrLFB5F7xc7FFhSpp177eDu/fC5LzU2
 rmRJbycSJ/OyUA3+7Fa8KN3WoKQQ6zw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-xhQhVINZO8yconu3BDA96w-1; Mon, 27 Jul 2026 09:30:56 -0400
X-MC-Unique: xhQhVINZO8yconu3BDA96w-1
X-Mimecast-MFC-AGG-ID: xhQhVINZO8yconu3BDA96w_1785159055
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so21609085e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785159055; x=1785763855; darn=nongnu.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AX7jsT9/zf/KqAg/8uhcqRDbZH5TTxg1c6I0SRHtYO0=;
 b=i6CFLOcIrF06OTz+ErNytPWbCOpsXQRRTAdrRQTzvDY1gBYfdGa5a8WYzirgAOwwnS
 pqb0ewu2pxloKEvB5me84+31WZYmQcLaAVRqEk7f1GSYIZWskJ8pUdZGOi4kTmJ3hLWi
 Gs/AeRCWfiiyXgTGJPKjodVOCgp+J5PRJOooYkGxKrUlp2Sf3bzEcsnOH0a4Msn4WSnJ
 Ykviu3qFilF+DMG6WqlbJOFP7kZ0Tn8wyrw+MND+69dcHTYEd/yw9nUvMFSVfEEogHz1
 Nm3FfG7mHa47zJ7SsCvvau3wXtrPm7KG48JY8aAQDxJnJMbGf9AQMJtVXhEX+VV+QIXE
 0+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785159055; x=1785763855;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AX7jsT9/zf/KqAg/8uhcqRDbZH5TTxg1c6I0SRHtYO0=;
 b=NFFp23tn4RFvErQzkEaDsoTXbBrFbeE9JTKxl1bgJEhkFIqbhZUZxPy2R31rgJHITH
 z3HGJCoEn1t3XrMeh6gbQ8uXnReayd9UMb8Co6ASdYuoJvBH+egAVAlCXaqZ22cSflQz
 ydME/gA/kToZVm+Cqi/vdji+MyKIIlXx6f+LWelRTMXJTzFhGZnEELbiGE/WmFDrkN9B
 v5DgVv418S/wlgPgskx9Wytq+QOH+QNGMvuDkYp2jr9sXrm1lvObhp2CUfadQwJQ+Cph
 Y3m/JqVD72Sg5dRafQcZyDNUqRr+OcmJnZLaK5csrwmSR7F15KIscPjoS6ckVeFV2PKG
 sMrQ==
X-Gm-Message-State: AOJu0YyhWeLhFAB/FBLllkTjKtlA21TyzS4uZZWz07mQJ6eIqfU4Is53
 /CwwOGAWaDtstvSwvYPN8/SouLPG7gBXBiPjtMTWA+Ll3It79AjhIwLUg7UladRQPv6+noA4/Ho
 N0Krhh+E+pkkCoL4v7nUV/cJb5cZCa/9lD16i0kzVMOCHmiFv5q+cTbwOMjCsUQW3RPxGgmQpS5
 nuVf6qof+EEMst+o7PSnixQVKpha2nZDmNmA==
X-Gm-Gg: AR+sD13Vupc3rQfSN4iQ3w3/jN9qe7XE1HYbAI+9lKVWMSarMjjCOI899oVKpc24lLD
 XBAczvG0ounpYSA71zLKUBjgyZ9N+K47Klcf09UsBstgdnDjnAKU8qyH6OYQIvZcxSNzIgWkPUh
 3fEz69xfHhfQkjVq1iNQ2b4cEh5cCXv2ZOfnM24FjoRYxquXIrajDLhBdimTuyp/z29PGJOitEi
 FliCEimMruAEe6WxethjKzhuCae2N/vIaYmdXaX0LDOVbyAkDHaBwv3ZDWMoKGJVp2noHDU8Tes
 hatDRUpN2iygDmuWXQHj0xJIbVeEozohs83hi/Tl+q2JWfv1YXOrchQ76Rw9nAvVtFtORO2ElcM
 FIJ67f7TpsFVPGZX4rBlIVw==
X-Received: by 2002:a05:600c:35d6:b0:496:bbce:fd with SMTP id
 5b1f17b1804b1-496bc0500bemr81322005e9.6.1785159054877; 
 Mon, 27 Jul 2026 06:30:54 -0700 (PDT)
X-Received: by 2002:a05:600c:35d6:b0:496:bbce:fd with SMTP id
 5b1f17b1804b1-496bc0500bemr81321555e9.6.1785159054358; 
 Mon, 27 Jul 2026 06:30:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4ee0e91sm226185675e9.4.2026.07.27.06.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:30:53 -0700 (PDT)
Date: Mon, 27 Jul 2026 09:30:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] meson: disable "maybe uninitilized" errors with -Og
Message-ID: <f559b622eb2d1a384b4f30583a8af10531f4b032.1785144729.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

GCC's "maybe uninitilized" warnings depend on optimizations
for code flow analysis, and produce false positive errors
with -Og. Default build gives us coverage with that,
so let's just disable with -Og.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 meson.build | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/meson.build b/meson.build
index 164328ded8..a119dae6ac 100644
--- a/meson.build
+++ b/meson.build
@@ -742,6 +742,10 @@ warn_flags = [
   '-Wno-typedef-redefinition',
 ]
 
+if get_option('optimization') == 'g'
+  warn_flags += ['-Wno-error=maybe-uninitialized']
+endif
+
 if host_os != 'darwin'
   tsa_has_cleanup = cc.compiles('''
     struct __attribute__((capability("mutex"))) mutex {};
-- 
MST


