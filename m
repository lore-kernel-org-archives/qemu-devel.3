Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67188C5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 13:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNAaE-0006aZ-7l; Thu, 05 Jun 2025 09:24:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNAaB-0006aM-GO
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:24:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNAa9-0004nl-Mz
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 09:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749129872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tAohEP55BJlnymenAZ+0FNK+cVxPghRTrJAK3inCGlM=;
 b=Cw89D/j5tkpob4Ffx/PAzocSkJfFs6ooIrc3ai5KvcpsN/srQDy9u+XPTj1S0GEAIwABuF
 zq9hmJ5LvIbBT35O8421TfLYNu7I8m1JLRYzfoKw9fnKeDMz/TfgdQ9m/0A4USlAkyKbC2
 8mkuoHRegvkAkWM/mylUZgTYEgTB1wI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-1utlpF8bM3OqFlIpfrqq3A-1; Thu, 05 Jun 2025 09:24:31 -0400
X-MC-Unique: 1utlpF8bM3OqFlIpfrqq3A-1
X-Mimecast-MFC-AGG-ID: 1utlpF8bM3OqFlIpfrqq3A_1749129870
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43eed325461so5821915e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 06:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749129870; x=1749734670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tAohEP55BJlnymenAZ+0FNK+cVxPghRTrJAK3inCGlM=;
 b=RsSkWmjDrW1+vxkOGNa/8MAnA8kHxKCUkJuNqYaC7G0rGMKtCgspBK/1uDmgZwpi2T
 cAruNfiBgyzjbR9IuzsoI7ari+qVF0R/U24txpWDTY9tU3MZo2DuNQwC7fgPP62chZUU
 lK3YX53ZGsr1ljfCm+l8k3VravH20DaLg0EfW39wx5yiMJikIeLVorMtYemw2wBmiWQr
 ttKcd7axcRjN4hO9KN1k1LTkkz7pFMDXQuXxtaXRnhW4DJpG5fMTK36THtVvOUa0IKGF
 MZmZINy81g62MdEee5avWNoD473Y3yAl09qz2okBsI1letar2zV6bp7JFfsMSHDsTati
 xd8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9YIDwX8nfWUMpo/E1fAb7go0kIqGMyJP4jjk6LsR/gByIWSeV/VSrtRQIp7YSlRWFPz0/RHGj7Lpm@nongnu.org
X-Gm-Message-State: AOJu0Yyb8FqibmBHXWpQrw0iAFUmlNqgDHC48wUWs3qrmguzM6j/f1ZD
 iFn4TCS4pWiuunhrtbIxZa1dx2ZwRrwUSVAiJt0aw8d8l1BShacmss1JVLQbavmjkMoSHAfKnC3
 kqKz80PIriQ6J2kOMsYskGBsrR43MQ4xgnitnLt2chREtIHCZ2Mdagzou
X-Gm-Gg: ASbGncvPmDOkvCAe+Blb70scxBBp6gtnoEoJZQKsWZ70T27K73WrWtvxGE3xv1TLUFp
 aIPLP7We8/ylrA2ChZZotueP3A9OCtwZIzHqlEysiKC7VC9BxCsd9gzg/p/An6A33G72MyjSUqO
 onXEznmY5clHDBrj9s/WwRTd7T/HDA1mBY4RmtjfAt8F7gJ3hTy5KAlo+Q3cqVr3KpuXazKjaN0
 IekByQ+YtDKHarAhRvwCFkDe9JxyWP+t0CqAFPH8yJ53R+/A12R8osdJ2o5SF5v+EGTW+6uzGy7
 +nx1GgY75C9UhQ==
X-Received: by 2002:a05:600c:6749:b0:43c:f6c6:578c with SMTP id
 5b1f17b1804b1-451f0ab417fmr67011535e9.15.1749129869974; 
 Thu, 05 Jun 2025 06:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3aikc1HiXCUx6zeX4RyAQ1tC4eqZoazeci/vuBCb2npfb3FSPrzs9a1gdbP2X4P6Iy6jOdQ==
X-Received: by 2002:a05:600c:6749:b0:43c:f6c6:578c with SMTP id
 5b1f17b1804b1-451f0ab417fmr67011105e9.15.1749129869542; 
 Thu, 05 Jun 2025 06:24:29 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451fb208926sm19225315e9.23.2025.06.05.06.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jun 2025 06:24:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
	qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@daynix.com,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 00/13] Improve futex usage
Date: Thu,  5 Jun 2025 15:24:24 +0200
Message-ID: <20250605132427.404551-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529-event-v5-0-53b285203794@daynix.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>=0D

> In a recent discussion, Phil Dennis-Jordan pointed out a quirk in=0D
> QemuEvent destruction due to futex-like abstraction, which prevented=0D
> the usage of QemuEvent in new and existing code[1]. With some more=0D
> thoughts after this discussion, I also found other problem and room=0D
> of improvement in futex usage. Here is a stack of patches to resolve=0D
> them.=0D
=0D
Thanks.  I haven't had the time to go through the final two patches,=0D
so I took the current Linux code unmodified and added the non-Linux=0D
changes on top.  But I have kept the delta locally and will get back=0D
to it.=0D
=0D
I also had to squash this in for CI to pass:=0D
=0D
diff --git a/meson.build b/meson.build=0D
index 20e8f37e6e7..34729c2a3dd 100644=0D
--- a/meson.build=0D
+++ b/meson.build=0D
@@ -843,7 +843,12 @@ if host_os =3D=3D 'windows'=0D
   midl =3D find_program('midl', required: false)=0D
   widl =3D find_program('widl', required: false)=0D
   pathcch =3D cc.find_library('pathcch')=0D
-  synchronization =3D cc.find_library('Synchronization')=0D
+  synchronization =3D cc.find_library('Synchronization', required: false)=
=0D
+  if not synchronization.found()=0D
+    # The library name is lowercase on mingw=0D
+    synchronization =3D cc.find_library('synchronization', required: true)=
=0D
+  endif=0D
+=0D
   socket =3D cc.find_library('ws2_32')=0D
   winmm =3D cc.find_library('winmm')=0D
=0D
Paolo=0D


