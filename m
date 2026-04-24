Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE73FED3EA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 16:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGJIg-00040m-Mb; Fri, 24 Apr 2026 12:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wGJIf-00040E-6M
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 12:22:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <elisey.konstantinov@gmail.com>)
 id 1wGJId-0004nE-GC
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 12:22:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4891c0620bcso51748445e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777047758; x=1777652558; darn=nongnu.org;
 h=mime-version:cc:to:from:importance:subject:date:savedfromemail
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=4vF3QcrJ9xV2lBs+Vve5Xf33ShwSvAyr03+v4VA/UVk=;
 b=qVbLHIjfB9SS/ZBZ6pkBBCCkwjj5GtdGMuLQLCjewIMjdLs+eH0qEIldoQByJQfL8a
 jKvwEIB+yF2jG7gtKGQi94M6w6Ax9NksxIvEWV2vOntHgTwQ611AQp9hBbpylAUfTqhq
 Cei0ZpoLxry3XIQTPbVtvckceb6xoQUh8JzcJea3NT/xTJIhX604Gl8YaQ3sh38J/UVh
 +5A0pOyolRsGi+sU2jGJb0N6UOGbgtu0uEnbpOySk0UvbKqZjzckMeyfaMVT7BqctX4v
 5O5KIyHsrQdj8tvuU4vzkSEElAfaWmo3hM5VRSLAFtxWZeVyBpb5lMy1v/4VuEG5Weh+
 KnZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777047758; x=1777652558;
 h=mime-version:cc:to:from:importance:subject:date:savedfromemail
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4vF3QcrJ9xV2lBs+Vve5Xf33ShwSvAyr03+v4VA/UVk=;
 b=OqSraSG6ugrW3MYUa6tjv59Y0sWN9EKaKerlYtZWqzLIXMPk+lEvRedKzL+giBlGEt
 3CtlgFckb1DBVDigRxDmOiugLBmTMvusUk25ZvnSHGBidcsNaopAd74QTwq7TIfSeRR2
 sRDK5jlQB6e4JkDLJt2/WIDDYpDXNEAUVrcwzxYsqhoaj4SpGhm9lD9OmNUDjbjyifuR
 XokROhwlbHcxMLpa/6he1LYTRpdJYRHCCQM1XtSbXXf5GddjvDynpT9GpO1ZuWgLZTYg
 B3mVEH6f0tsTM+Cw9s4qJQqUuejVRMDL4n0uL1MlQc3fI6vDkbkrMgsXS8s8W/35NuMo
 XYZQ==
X-Gm-Message-State: AOJu0YxkVkGJFsQORCR4W9NhR8Fep7kT8i7BrBgpy8E5NWQ7Y6M8cpSS
 0liZEoqWTeFxPSjkG8ovt21govrGXa3kQP2DwPIhcVlPeKi+027OVRWC
X-Gm-Gg: AeBDievhfPZrxI3aS3CPDE+65cARQvm+6P03Iucxpohfr8H1kKa3x0YTxYD9jQkzoNA
 G32GtIz0labzmUw9JGo//GIthTnpC668cINxnoMyaK2uJ/W9Bx8Wg1ehS1ZNMhQ4Am35Of+VfXn
 j1s8OoLUPv4Mc9rxwxJEl9V6Qzki5ekd2iZqZpgWRfXHi/hE3Ui9vfRfjhZ15F54ByNzFFleG/R
 xdQ323HlhLQJ8X7Ha3vAn/8iEAazy/CBjUA7psgeICG05N+Ons2T7VuelDmWCzIMv6fCraQi+EO
 /yQ6K4BxTVlUrVYvHDLfHDh6c0x4XoxqgvuRNdyoIudI3q9auXS+poh6T+Vr8mAg/1/HmcY1FxE
 PZ1rprg5g8drwaRw0vWGTQgW6YGEWwJR1wsunELm1cCGeB3a5IMTCgReFFCs978Mvfd7FVsVwTk
 kY/0N5epO0pMRH9wYCN9Cf9IAnCxqO8G16LiRFpwor5Cd/AX4mCezV
X-Received: by 2002:a05:600c:c177:b0:486:fb0b:ad79 with SMTP id
 5b1f17b1804b1-488fb78129emr423167545e9.20.1777047757780; 
 Fri, 24 Apr 2026 09:22:37 -0700 (PDT)
Received: from [192.168.100.13] ([188.138.129.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm729849745e9.4.2026.04.24.09.22.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 09:22:37 -0700 (PDT)
Message-ID: <69eb98cd.050a0220.35705d.4552@mx.google.com>
SavedFromEmail: elisey.konstantinov@gmail.com
Date: Fri, 24 Apr 2026 19:22:36 +0300
Subject: Re: [PATCH] build: prefer sigaltstack over ucontext on Linux
Importance: normal
From: "elisey.konstantinov" <elisey.konstantinov@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org,
 berrange@redhat.com, marcandre.lureau@redhat.com
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="--_com.samsung.android.email_226362425930820"
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=elisey.konstantinov@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

----_com.samsung.android.email_226362425930820
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

QSBzcGVjaWFsIHRoYW5rcyBmb3IgdGhlIHBhdGNoOyBJ4oCZbGwgZGVmaW5pdGVseSBnaXZlIGl0
IGEgZ28sIHRob3VnaCBJ4oCZbSBub3Qgc3VyZSBhYm91dCB4ODYsIGFzIHRoZSBidWcgZG9lc27i
gJl0IG9jY3VyIG9uIHg4NlRoaXMgcGF0Y2ggc2hvdWxkIHdvcmsgb24gUFBDIGFzIHdlbGwsIHNo
b3VsZG7igJl0IGl0Pwo=

----_com.samsung.android.email_226362425930820
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGh0bWw+PGhlYWQ+PG1ldGEgaHR0cC1lcXVpdj0iQ29udGVudC1UeXBlIiBjb250ZW50PSJ0ZXh0
L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPjwvaGVhZD48Ym9keSBkaXI9ImF1dG8iPkEgc3BlY2lhbCB0
aGFua3MgZm9yIHRoZSBwYXRjaDsgSeKAmWxsIGRlZmluaXRlbHkgZ2l2ZSBpdCBhIGdvLCB0aG91
Z2ggSeKAmW0gbm90IHN1cmUgYWJvdXQgeDg2LCBhcyB0aGUgYnVnIGRvZXNu4oCZdCBvY2N1ciBv
biB4ODY8ZGl2IGRpcj0iYXV0byI+VGhpcyBwYXRjaCBzaG91bGQgd29yayBvbiBQUEMgYXMgd2Vs
bCwgc2hvdWxkbuKAmXQgaXQ/PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9ib2R5PjwvaHRtbD4=

----_com.samsung.android.email_226362425930820--


