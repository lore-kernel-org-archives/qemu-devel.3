Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F4BC87FD1
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 11:15:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uit9j-0001HM-6B; Mon, 04 Aug 2025 07:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uispu-0002h2-8b
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1uispr-0006jf-FL
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 06:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754304869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=+Lx08PaopExWH3VO4TJdRX3uJjsFXOpQeOlmu5rnhlA=;
 b=QJgx6Q5NiMrS30tbun/U83zJRwh2NvPlItjZ7sEd9PjE0yKQpw9d4GEkeixsnOYTyJLO+/
 zvdsvXISfBM5iRfbwHpNJ4tbe8/e8qat9YK89lF9M6gWe5/dE7YDdpzycdBzo0cwtJLEm8
 pR+H03qTA5Y5ZMgDAX5DqNzc7DM+Jtk=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-6lA9n_M9M8Kkvc2od4O4UQ-1; Mon, 04 Aug 2025 06:54:22 -0400
X-MC-Unique: 6lA9n_M9M8Kkvc2od4O4UQ-1
X-Mimecast-MFC-AGG-ID: 6lA9n_M9M8Kkvc2od4O4UQ_1754304862
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-7073d7fbfe6so75376356d6.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 03:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754304862; x=1754909662;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+Lx08PaopExWH3VO4TJdRX3uJjsFXOpQeOlmu5rnhlA=;
 b=g04FkUNjWOIfjM3yUBlhWUD/JnauxZrF+CY+SWi2dTTKFWhBymcEjsiUxdv8AP8LlK
 PdlpbS6C0LQHkXvblNuIVyYq4SR4WsmP88Rf/HdSM4f65iFuMIAbV4LSp3yCCZmv0k5f
 hWzo6Z0J4W8XziJUS6+/Gg2ZQ524341PN8l3JdNwBFODCYvA8BxiDHJZTedFNJA3ygxM
 KHqEthbDWUtBUHw4ByNXdPNyEOqjO2UL6AxA9LDkbXUUUj2ilSMpmXyb7GhanOD5BPje
 xknMQf7gRy3StzxhBy9LV68jozHxv0mx7FQlKMhULClLa/UD08LrX/bFp0t4h/+MAFrY
 c0AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS7XquaDITEj8ns56MOCfxJwM+Zk8rFGgy7eX9mPs2Ma5+c6YIw9aBpqccCjLn0T3crlSdVt4RBEWn@nongnu.org
X-Gm-Message-State: AOJu0YwJ/KgDuwgHjVYuuZ7WjkfDlPPPHfcwMOYz/9rjgqCphmEQHVY+
 TUkxUeVyxK9Lqy0W1n4BPFNnfjpCzO0tN2Agz8Pd+68MOjA+wBFXCKSZh8kyaZAHBTWU+dNLQuh
 N3feBStQlM9JAuZ9NFH3MO0ZNbbppKD1Du0V0ggUiuXZKZ2+UW+sXfRgydRHCuEkCzI1IOwF1iy
 cjF0NwGDc5xo3wnCx2InGLiH9BTHlkwA0=
X-Gm-Gg: ASbGnctrCdESZd+0Q7Pilc9Kx8Xdu19IM065c/nRrCpbmxrbVDPqEQG6JcO28Lt3yyW
 dGBLZSbPp0/9DowfeHQ8QwPd5rkEzHoqTcptg+upiOvabSBcRFmjoZzf4TrTk6ZzloTzgu6nh6R
 9IQ633QK/cCzjjKZkACH+GjMc=
X-Received: by 2002:a05:6214:19eb:b0:707:4d59:cc7b with SMTP id
 6a1803df08f44-70935f34ec4mr146898106d6.2.1754304861727; 
 Mon, 04 Aug 2025 03:54:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9Uy6MGywFH0B3h+R4y5Azb8dAH12BrTq5SntF3JICj1Y+UXHSFgoDSzGxOm7bc/GgVTpa8MdEeJuXKuoR7VM=
X-Received: by 2002:a05:6214:19eb:b0:707:4d59:cc7b with SMTP id
 6a1803df08f44-70935f34ec4mr146897866d6.2.1754304861375; Mon, 04 Aug 2025
 03:54:21 -0700 (PDT)
MIME-Version: 1.0
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 4 Aug 2025 13:54:09 +0300
X-Gm-Features: Ac12FXy3QjXsun2ymfRUrWtMA3wvRFaPHuDG-SvhK9fvU3yXNkzwomyqW1k3J4M
Message-ID: <CAPMcbCpSQS5yWUCcGum6nWq=+HTaxFmJjm57_cgmJp+fMtC1JQ@mail.gmail.com>
Subject: QGA installation issue on Windows
To: Michal Privoznik <mprivozn@redhat.com>, Jan Tomko <jtomko@redhat.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>,
 =?UTF-8?Q?Daniel_Berrang=C3=A9?= <berrange@redhat.com>, 
 QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000001724ee063b87ee7b"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--0000000000001724ee063b87ee7b
Content-Type: text/plain; charset="UTF-8"

Hi Michal,

I want to discuss your patch
https://gitlab.com/qemu-project/qemu/-/commit/c6f5dd7ac8ef62dcdec4cdeda1467c658161afff

Unfortunately, we found bad behaviour on Windows. On Windows, we run QGA
with `-d --retry-path` options by default, so we expect that QGA will start
even without the vioserial driver and will wait for communication
forever.

This worked previously, but after your patch QGA service fails if the
vioserial communication channel is missing. This behavior is totally
unacceptable for us.

You send this patch to fix a Linux problem, but it causes a Windows problem.
So, what we need on Windows, if --retry-path specified, we should ignore
any channel error and retry the connection. If -d and --retry-path are
specified, it should become a daemon first to make Windows Service Manager
happy.

What problem did you fix for Linux? Can you explain in more detail, so we
can find a proper solution for both Linux and Windows?

Best Regards,
Kostiantyn Kostiuk.

--0000000000001724ee063b87ee7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Michal,</div><div><br></div><div>I want to discuss=
 your patch<br></div><div><a href=3D"https://gitlab.com/qemu-project/qemu/-=
/commit/c6f5dd7ac8ef62dcdec4cdeda1467c658161afff">https://gitlab.com/qemu-p=
roject/qemu/-/commit/c6f5dd7ac8ef62dcdec4cdeda1467c658161afff</a></div><div=
><br></div><div>Unfortunately, we found bad behaviour on Windows. On Window=
s, we run QGA with `-d --retry-path` options by default, so we expect that =
QGA will start even without the vioserial driver and will wait for communic=
ation forever.=C2=A0=C2=A0 <br></div><div><br></div><div>This worked previo=
usly, but after your patch QGA service fails if the vioserial communication=
 channel is missing. This behavior is totally unacceptable for us. <br></di=
v><div><br></div><div>You send this patch to fix a Linux problem, but it ca=
uses a Windows problem.</div><div>So, what we need on Windows, if --retry-p=
ath specified, we should ignore any channel error and retry the connection.=
 If -d and --retry-path are specified, it should become a daemon first to m=
ake Windows Service Manager happy. <br></div><div><br></div><div>What probl=
em did you fix for Linux? Can you explain in more detail, so we can find a =
proper solution for both Linux and Windows? <br></div><div><br clear=3D"all=
"></div><div><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"g=
mail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Kostiantyn Ko=
stiuk.</div></div></div></div></div>

--0000000000001724ee063b87ee7b--


