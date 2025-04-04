Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCE9C36014
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 15:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0j5c-0001Xl-3K; Fri, 04 Apr 2025 11:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <valentin.david@canonical.com>)
 id 1u0iJu-0004m8-4r
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:46:58 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <valentin.david@canonical.com>)
 id 1u0iJs-0003z6-73
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 10:46:57 -0400
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 59FD23F6C3
 for <qemu-devel@nongnu.org>; Fri,  4 Apr 2025 14:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1743778008;
 bh=OBrrHwdCZ7T5XlCNdowcNSMQRkdiDflQJB4iVbFiEog=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=tIWvLsuDLeXpwyi6PcutXn3pPnSMyYEJFaGFfwHuAeWJe0EwdwVbiAIooVtc8oaUb
 DrIUHeLPLNylqxMhEKx2//LOSYEyJUQBQ3dVWx0BrefjGhGwj5jt4bnBfBTFYcLDw8
 RKisl/lvv2Ah5lH1YQyEIWP7N6Csmfj7GWbrSihK7WqogiNlzb+rREX8oszdt6bsDc
 vgBToZUevRY/FshMkbxUtmoUGu39huozzam6jNVEpsPt1P9ggdWUu8CbugIzeFPy76
 nhGtXbjbVMVlmYEQ8AMOv9mwjwd3PVgZua0MUBpeWhrrrrwUrnGyB44tBb7YPUpQiM
 hX7vxBzoKS3jw==
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff854a2541so1972336a91.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 07:46:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743778004; x=1744382804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OBrrHwdCZ7T5XlCNdowcNSMQRkdiDflQJB4iVbFiEog=;
 b=JWsZbSt5CZvW7ADpbFd4Eitmtigl84NeXok2RqYI5ThHzZXuuvaw7U1P8LLGfFLEQF
 GBjhjeyvVcC1SOCZ3VLid2IzCyVHLOto6ACqHmNY/lPKPkaYvPQI6dTW5//ZhM6t5IwF
 xMtS117O3vtCL6OKnB33DGxGKGn3YB5wcsceDDMxsjWRGmxRNtEwMf/l0ObJk/PbTNGM
 ZD/wgBpqRVs3czH7itDNMg7BJ55gSWCNKr7Qgpel4aV/aDww/raAo4k9x7GreoVTnEzW
 DOx5NWAviN7nkIA8zKJGW9ifxCNWedGVR7JQZB5VysIyiYwOyIHMgyUsLQKwgCs42Q/1
 S3vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtNhrmoWoNHpn7JfDYcMajOBud563jf/MYaEuQ7g8DWZ5V0m7VhhE+hZ9KBjXAPiZDL3+nS9kHtsL6@nongnu.org
X-Gm-Message-State: AOJu0Yw6O6q9+YBWWobdBEpsAKwEzn9mj+TCGGurXscNqY4KnWm9ffNS
 krZ7LLMVPbUzuQp67AfsDQk8jOaAaNGyoHe3FHOka8kff/l4azWpRIcsvwBgy667are2HDZm2ct
 V63oLJINIGzPfYz3fiEmlj4hCGLhYFHIImudXYQqd4xtin6kbxAz9ZNlul4Xs6SlfFEHRInKyKE
 K1mVhY0an2IrZDSOIYVCVVkf74CM7Eqshs4kGsVhRxduk=
X-Gm-Gg: ASbGnctJpsR1J7ZtjjDRtQ8crA1qzEc8qQvSBZHqjSuDlgOvKde1S7EZu4PCXdqbi3q
 XuPjv8jSJ9vB3vGsPyae4uUSAHSkD+Kix/V7393JUpeNBdAv1eXXemiiPN90Fz40CvKT1iazi/6
 Z9atYz1nN4
X-Received: by 2002:a17:90b:5683:b0:301:98fc:9b51 with SMTP id
 98e67ed59e1d1-306a4821cf3mr5049644a91.5.1743778004103; 
 Fri, 04 Apr 2025 07:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRRuDGjCnOZFBf3xxiFDwC9SrquFzkb96IASOAsgh5mtSh8cZhN4oRSHHVI+MdvDCkzBMT7trF7u9cGae2Dgk=
X-Received: by 2002:a17:90b:5683:b0:301:98fc:9b51 with SMTP id
 98e67ed59e1d1-306a4821cf3mr5049621a91.5.1743778003873; Fri, 04 Apr 2025
 07:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250323213622.2581013-1-daan.j.demeyer@gmail.com>
 <CAO8sHckT2Ko8TTJjzUsX0znafaL_4jp97QCtSxoZDnHow0bEAQ@mail.gmail.com>
 <aabb0497-016a-4cdf-9098-dbbaa92b781d@linaro.org>
In-Reply-To: <aabb0497-016a-4cdf-9098-dbbaa92b781d@linaro.org>
From: Valentin David <valentin.david@canonical.com>
Date: Fri, 4 Apr 2025 16:46:32 +0200
X-Gm-Features: AQ5f1Jo1MYUE7qGn7PlpZ74NXGcp_q52PjrqI0BCmwjvAVcKUfRQznzDGugDeNg
Message-ID: <CAK00H8NhzV6ZDr1Kisr2_GUr0b-7W+FKgekQOF_iD61-J1mh5w@mail.gmail.com>
Subject: Re: [PATCH] smbios: Fix buffer overrun when using path= option
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org,
 thuth@redhat.com, 
 mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000007d01890631f4f41a"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=valentin.david@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 04 Apr 2025 11:36:09 -0400
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

--0000000000007d01890631f4f41a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 9:37=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> Also I was hoping I could get feedback from Valentin.
>
>
Sorry, I did not realize that you wanted my feedback. Daan's patch looks
fine to me. I have manually tested it and it fixes my issue.

--0000000000007d01890631f4f41a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Thu, Apr 3, 2025 at 9:37=E2=80=AFPM Philip=
pe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linar=
o.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">Also I was hoping I could get feedback from Valentin.<br><br></blockqu=
ote><div><br></div><div>Sorry, I did not realize that you wanted my feedbac=
k. Daan&#39;s patch looks fine to me. I have manually tested it and it fixe=
s my issue. <br></div></div></div>

--0000000000007d01890631f4f41a--

