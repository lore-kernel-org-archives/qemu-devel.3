Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEBADCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 14:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux4hz-0005gj-TF; Fri, 12 Sep 2025 10:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1ux4hw-0005f2-A2
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:25:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1ux4hq-0003IJ-FH
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 10:24:58 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45b4d89217aso14262165e9.2
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 07:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757687089; x=1758291889; darn=nongnu.org;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ZyCCafLVvV0UlSRYrEruuSHnOO/jo644G6MfDusof/0=;
 b=jMQF0hrIbE++rQNGXmcEUQgF/hulslU9V0KTT2kUuC1btHHcs8RK9T4gnWA8EDkDkJ
 /GzUmmocw2ZZBGgiTF0MH2Cd8td7iC8O83ZgnpvkzlutX0urKc/bdrYxhoDHu1SGGotT
 IYcBBWccWmsRDT2BatyWUUDyPDmI5TUsFVLadtzXzx936U2MvIyYga1tiUQc18iG1ZWF
 /ZqdCLziiMneXnH00la/RPiiFRWNUsp2TXVTTMZIDjyRQByBDvwrr9rPkCc6cfRAZ1LN
 KdcfN+8aJNY406svdOOViV04vhQDFZWKysZNZSviKV6Dy00TCH31vW+OqH/Jfzn+S//p
 A1ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757687089; x=1758291889;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZyCCafLVvV0UlSRYrEruuSHnOO/jo644G6MfDusof/0=;
 b=F12kAg2vbWRjLaAXndvKrRjq6gdUYur0JEzpLHRezthTE2lNQLDILPuOezUHcIWFNw
 6c2+aP4CgRcOv42LTU+bzWt0+OhS/2gpXZFwZLFzV+a/2kgbBhMnAg+N3QuLb2OGwnaU
 Xy5ZFHqBKHO1Fp6bPSdTp7sxtLCHT+Fc9PbIqUh/445deWtQo3ziGj5/stgdizmlSEOU
 W52gYr7CMdUIUbpt7ZOBcehKWcx2yyK/EoiiM6KWfGJ5C20mCE+wfGkIlfc7zQX2FnmX
 dEoRZlfvkndWiguU62jBYLeBfPTIwsI4UmgRG3JjQHBhjxRvr92xEFNS8njw8/NCn0su
 uXRQ==
X-Gm-Message-State: AOJu0YyW96yb1NgK+RZqUt1xsHUF/3eGiw5GQ1c/CpS9ZiXG8i+j0Y/7
 ONaUGiD29pIEbsWVp234W/CrdfgfVkwTPzcwrdCBkmYBsO59bo8+B+ge
X-Gm-Gg: ASbGncvouxbyqXf2Tbbov6bDrLEb4QFd3Xbme9pG82yceRzecKpmL01+m4Mkcq10nQw
 lIxLCgr/MeAq7cvM+EgJB5CarpDhcd6TRPRcbktX6m6Wv9OcxnWXuQ352Myg/rmfJw4FAz4t4Xm
 Lw0bQurKoblWKdV/Z/+JCXqmnNP6EyCWK74g7EsBNmKJHDkrgQo1esismf0/gO22GxmSaGl9U0C
 HvkUdEuMMFFuAPq4nA1FVP+60gFt2s3ATYsq+c4oRUW1kAzTEAhZhRD2BTO1tGpkiTMhTDcbIXt
 X7VjlPe77Mw+hD2bdxFRvxDZ4AVhDCiWMoJmM376nrEhtRtpzqOxK4c8MJqLlxbuIOcIGWyxklM
 FeHaBki6omoJI2vbh/jFNftfxmqHJcwKNm8ff6ziB43pkBuUsfecX1PBOyg==
X-Google-Smtp-Source: AGHT+IH0Th07+gQJRkf8cLgaYEtz6KoW2mYxvKolAzW3RSaa9YdQ7qFxNC/U1W8bM/6GyJ9dLrfZbQ==
X-Received: by 2002:a05:600c:45c4:b0:45d:f7f9:9822 with SMTP id
 5b1f17b1804b1-45f211ef820mr35730975e9.12.1757687089161; 
 Fri, 12 Sep 2025 07:24:49 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e017b2a32sm67800485e9.18.2025.09.12.07.24.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Sep 2025 07:24:48 -0700 (PDT)
Message-ID: <a37e5e5d594634d6cc73aa13b0853089a3964ec4.camel@gmail.com>
Subject: Re: [PATCH v4 00/10] virtio-console: notify about the terminal size
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, Markus Armbruster
 <armbru@redhat.com>,  Eric Blake <eblake@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum	 <marcel.apfelbaum@gmail.com>,
 Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu	 <zhao1.liu@intel.com>, Szymon Lukasz
 <noh4hss@gmail.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=	
 <berrange@redhat.com>, Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Date: Fri, 12 Sep 2025 16:24:47 +0200
In-Reply-To: <20250912042910-mutt-send-email-mst@kernel.org>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912042910-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
MIME-Version: 1.0
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32d.google.com
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

On Fri, 2025-09-12 at 04:41 -0400, Michael S. Tsirkin wrote:

> > The patch series in its current form provides no way to disable
> > the console size functionality,
>=20
> Well I see the console-size property, no?

That only disables the VIRTIO_CONSOLE_F_SIZE feature flag, but
VIRTIO_CONSOLE_RESIZE messages will still be sent to multiport devices.

I could of course change it to dislable those messages too. Shall I do
so?

