Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325A8C36008
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 03:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzSJS-0002uH-AX; Mon, 31 Mar 2025 23:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzSJP-0002tc-1j; Mon, 31 Mar 2025 23:29:15 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzSJM-0006PK-1s; Mon, 31 Mar 2025 23:29:13 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-30332dfc821so7103206a91.3; 
 Mon, 31 Mar 2025 20:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743478150; x=1744082950; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SBHBZQBygJrkuYmvBUgz98ilFLgpfVe79oWnJ8DMj7A=;
 b=PBWNglJpv6pPP0YbL9oeS5rneROogLosyKCDOHBnfB5M6t8jJ2LUq9DR8/PHSgNDsR
 hu2b69rda06Q1r6bHhtWIv+yHNZOWjcxV5ix11x/YtqSo+Wiqr1gNC9NPAHINuWG3Kl8
 ZEfy23+dlQUUr65N4XeRMU2KMACeWzJ38sN5L0g5MOwgA++yILQUxrzrU+TrB+RvElPb
 b8n/PCaUQF9QZr3FwhNgQhLPlkwyiz93brIpI2zgmZCu9pHJg9EAgQvrasqriT3Zi9QX
 chUCVvl0Co8QKyVNRrKn5FgpA10+XShGrKVTZUpymRJEhmSjppz67GE6RpmBuOe+0XJf
 61fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743478150; x=1744082950;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SBHBZQBygJrkuYmvBUgz98ilFLgpfVe79oWnJ8DMj7A=;
 b=WBmnAE7RbqsoR1kZ4zt2Kn4uIplkXazStWkfPR6rT5NhJLwhcY6vvihfwTn9vaNaio
 GNAEdAfW8JX32vkYDZB2X7R/zl8v7p6XEvOnfRczkSUWub+dpITopEpPTmw9mEfFleDN
 qdGSty963N2wGZ1SXsGd7kCpB9O/TLienQTVX28ofQxcy92ThBdnb4NENin/OsLTxmnk
 hAzkZQl21mT2O2hZa+1e53aASB3Ef6tSziwJOQw4DIljxBaSybXnIf7m4mtNh3FyGubN
 ZzJBaKkG9C9n2drGVvKiKrR7bA8gWujYlFXpFN28gNwJv4WGe/PzeJh2ZW4e/DYQWeEc
 BI7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf9+Jnd03WX5HYATpeBQ3NMn75K6ib0Pp5OVRVH+uV9RaWveLCCEKjr8L9LX5l+vxsZLt128sKr9c=@nongnu.org,
 AJvYcCWUcdckVRIQJL/O2AUjaCLutqznOn3SlXxD8fF0JOuW8lTetezS6GGaG0YI+p8uBs7OTQSRQiepb3hc@nongnu.org
X-Gm-Message-State: AOJu0YzmK3nsPWlhy70AbIqRKq2E1hPNVvL69HfYitDlLNmAW1OOWwtn
 6Wi7BLWqdyHww8r+ARxR98c6nPPkTzfBnKEx8dA6TGwxPEgR8GUX
X-Gm-Gg: ASbGncvMbY16sY1KyRJeJO2uvUTRTMkbGlxp/uPA0tx3ixJdSeBaW1Jpn/bV9qQYtow
 5iSubXt1uAvXtd3jKyEmeQ//x75PTA8yotXGCo9Fj0/18g2PhpvYhbuF41n47RwOXMHglfAoGkU
 VEuUDf8agWP9keyOo3RneBYbJfuzA0Gw7H6d6wYE9qd3BGTpPkH6P9bHna2QfIDqMyA1XyEo/KQ
 xdhL2uJSYFiclHjLLmjDHg3mtVzqJlj3uZgeHdBtGmo1BE2AxQqjdyth3RYvm8o+hHr8rdeTM+N
 0toqq177qUUDu9NP7XW9WMxZ0aT+mIbuVs83qY4=
X-Google-Smtp-Source: AGHT+IFfR5Fh++V0ykygpADJOAQc9ba1pbBpNcDL9vss9QDbWvmUX3dwjgv7lsmY0AfYvchODwF6kQ==
X-Received: by 2002:a17:90b:2e4f:b0:2ff:702f:7172 with SMTP id
 98e67ed59e1d1-3053216e3f2mr18445200a91.33.1743478150099; 
 Mon, 31 Mar 2025 20:29:10 -0700 (PDT)
Received: from localhost ([203.185.207.94]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dcf48fcsm10465540a91.0.2025.03.31.20.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 20:29:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 01 Apr 2025 13:29:04 +1000
Message-Id: <D8UZF6NLQG6W.3IBC5MPZBFZ1J@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, "Harsh Prateek Bora"
 <harshpb@linux.ibm.com>, "Alexey Kardashevskiy" <aik@ozlabs.ru>
Subject: Re: [PATCH v2] ppc/vof: Make nextprop behave more like Open Firmware
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250331142627.BAA2F4E6029@zero.eik.bme.hu>
In-Reply-To: <20250331142627.BAA2F4E6029@zero.eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue Apr 1, 2025 at 12:26 AM AEST, BALATON Zoltan wrote:
> The FDT does not normally store name properties but reconstructs it
> from path but each node in Open Firmware should at least have this
> property. This is correctly handled in getprop but nextprop should
> also return it even if not present as a property. This patch fixes
> that and also skips phandle which does not appear in Open Firmware
> and only added for internal use by VOF.
>
> Explicit name properties are still allowed because they are needed
> e.g. on the root node that guests expect to have specific names as
> seen on real machines instead of being empty so sometimes the node
> name may need to be overriden.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> I've tested this with pegasos2 but don't know how to test spapr.

Boot a pseries machine with pseries (book3s 64-bit) Linux kernel
with x-vof=3Don option.

AFAIKS the two places Linux calls nextprop look like this

               if (call_prom("nextprop", 3, 1, node, prev_name,
                              pname) !=3D 1)
                        break;

                /* skip "name" */
                if (prom_strcmp(pname, "name") =3D=3D 0) {
                        prev_name =3D "name";
                        continue;
                }

So, seems like skipping name is okay?

After iterating through properties it also has this:

        /* Add a "phandle" property if none already exist */
        if (!has_phandle) {
                soff =3D dt_find_string("phandle");
                if (soff =3D=3D 0)
                        prom_printf("WARNING: Can't find string index for <=
phandle> node %s\n", path);

That warning does not seem to fire after your patch.

spapr *seems* to be okay booting, but I would not be inclined to
take this for 10.0 at least without review from someone who knows
more than I do about OF since there can be subtle breakage.

What actual problem is it causing for pegasos?

Thanks,
Nick

