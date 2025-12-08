Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22DA9D3B7F2
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 15:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vScnp-0006l0-75; Mon, 08 Dec 2025 10:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vScnn-0006kn-1i
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:05:27 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vScnk-0007yG-Cb
 for qemu-devel@nongnu.org; Mon, 08 Dec 2025 10:05:26 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-477563e28a3so32813445e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Dec 2025 07:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765206322; x=1765811122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8M3ROv/5s7FMxpG3DgZmvgt3n04NIgkKXbrt9I27YGM=;
 b=D+wvKLaE21588TjlYKSP7wvzYKMe9F0CF25seBDjMuC0G1WEozPHL2ABIHJna3NZa/
 gFssoBM+rUIY6XpYbI/4MrWhDand/0OmbiyhicisVzJa5T301Qioi72yJp4d76JbjpXF
 xm08mB1DZDEY309Dx1YYceVtty11Oa+2T5qTN/ChuM3yytlilrG1gsVkuahTr34oW05m
 gsAlDe9uZ2PC5o4s2GCQirXEK6HVtmZ8vfMMbCUzvT8sscn9FIJRkol4FWVYAh3q/9Po
 2CiIlmWcsWuMo+kVOiO5LRVBvBM9RLOq/NngM+J+CXKSbmVlhUTU95hpzgD0zrAJzDNx
 kcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765206322; x=1765811122;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8M3ROv/5s7FMxpG3DgZmvgt3n04NIgkKXbrt9I27YGM=;
 b=RbcvgCA4e1cXmYh5aCISM5nVyDKKnbeUAQIf7tWuJwRtyp8rYrB/E4KnUc3O1sC6jJ
 k9tbGbD9COCrwdoMXeG64VwCLVSPWzLcEPdYdEH9NWuh9+PpnatudoseoAM0olvuqRMm
 AMCKwWmu9TEquResGOVj9+iR/yv+MEOPZnnl9R6yNL9+GzfYQ+JtNKVTe9E8eKa2DWwd
 zOMofOe3MACQNPeqy1wKOcUOoyrS993NHh9lL1eOGu81Negvig2sAnbqv5HgZVZPdsOo
 hn+TFBybCER4BDSdByTbMs9KCMUyerlR14dMg4IRYWAHothCWiEr+C6ujgFtfxzh+8KK
 OXRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiykqW3X8wJWdeNIxSodeWBRjBj6Kg8JJx72XR369WIatpOTzmFQEhZvln2gOJFWsSfTBMi9GJlK7f@nongnu.org
X-Gm-Message-State: AOJu0YzoZuZ94QRZjK33CxOLf6KTIFGfNHNcXSrJFWnzvzoefRncHEVA
 BRfTdpupOpgnkJQk6WSeS9NtUjpw7oMg/X/vLwB5br7jGtnYHub0m3pGO1Kmth7k/iQ=
X-Gm-Gg: ASbGncuMr1zUsSi94nq9vkLGqc6Zi7r5xRbvHK+7TK7797cZMI9B8fNHg/WUot+j8n3
 VfXlk2hfeGguGdExFoG3uq/2kktO1pVO/vURqunMVkKN7CKkLDKW9Acz9ysFoOLA1tix4AVXuFt
 0hgO7PH2Jx0bLKN6HgItUkQqrQ1hcz49kl0Xxaj7gcqUOl9lryNqo01rj05WdoVFgtLIWUyeNIE
 4jRsdENbUGFpt7R4EyYLZ9jDUL495gk4Gg09TcxG5EJs3zFP749sYSbe2rMVKPDnHH8MnJGz2zd
 CXIzEBmShNdIyCTrMY1UzSA8c44aDrtWG0cRudQ1EzwJ6YMmb3M0Cx2yhTPlqEiYDlal8nyL3nr
 zDNWrb5Xn2ORBZ8PD/EP7T0ha6R/J/dAe56bufoNada1fclP6Gpp3z6QSnCNjv0q2pBZRD0Luoj
 FJ1jO9WHCWUHY=
X-Google-Smtp-Source: AGHT+IHBoZ7ECjZCkxc8D0a74IiW+9EcgGXKFlFqiVWtf2YN8Vctcu4KR33M8P430c4noXYrTdAsEw==
X-Received: by 2002:a05:600c:a08:b0:471:5c0:94fc with SMTP id
 5b1f17b1804b1-47939dfa053mr103293515e9.6.1765206322415; 
 Mon, 08 Dec 2025 07:05:22 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479310ca502sm255089185e9.7.2025.12.08.07.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 07:05:22 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 523E15F831;
 Mon, 08 Dec 2025 15:05:20 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Albert Esteve <aesteve@redhat.com>, Alberto Faria <afaria@redhat.com>,
 Alessandro Di Federico <ale@rev.ng>, Alistair Francis
 <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>, Markus
 Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>, "Daniel P.
 Berrange" <berrange@redhat.com>, Chao Peng <chao.p.peng@linux.intel.com>,
 cjia@nvidia.com, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 cw@f00f.org, demiobenour@gmail.com, dhedde@kalrayinc.com, Eric Blake
 <eblake@redhat.com>, eblot@rivosinc.com, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Elena
 Ufimtseva <elena.ufimtseva@oracle.com>, Auger Eric
 <eric.auger@redhat.com>, felipe@nutanix.com, Alyssa Ross <hi@alyssa.is>,
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, Jan Kiszka
 <jan.kiszka@web.de>, Jason Gunthorpe <jgg@nvidia.com>,
 jidong.xiao@gmail.com, Jim Shu <jim.shu@sifive.com>, Joao Martins
 <joao.m.martins@oracle.com>, Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>, Max Chou <max.chou@sifive.com>, Mark Burton
 <mburton@qti.qualcomm.com>, mdean@redhat.com, "Ho, Nelson"
 <nelson.ho@windriver.com>, Paul Walmsley <paul.walmsley@sifive.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>, Richard
 Henderson <richard.henderson@linaro.org>, Shameerali Kolothum Thodi
 <shameerali.kolothum.thodi@huawei.com>, Bernhard Beschow
 <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth
 <thuth@redhat.com>, wei.w.wang@intel.com, z.huo@139.com, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Subject: KVM/QEMU community call (9/12/2025) agenda items?
User-Agent: mu4e 1.12.14-pre3; emacs 30.1
Date: Mon, 08 Dec 2025 15:05:20 +0000
Message-ID: <87bjk9hv4f.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SORTED_RECIPS=2.499, SPF_HELO_NONE=0.001,
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


Hi,

The KVM/QEMU community call is at:

https://meet.jit.si/kvmcallmeeting
@
09/12/2025 13:00 UTC

Are there any agenda items for the sync-up?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

