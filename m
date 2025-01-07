Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0972E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV7bm-0001OB-Gh; Tue, 07 Jan 2025 06:18:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tV7bl-0001O0-DR
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:18:49 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tV7bj-0001CL-Ab
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:18:49 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2163bd70069so33782105ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 03:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736248725; x=1736853525;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hoznFOBSphqP4gcOgEi27/LzCX1DhAknL37Btcf9VZ4=;
 b=EkUVZqqnav1TT+x9l9/f8XbSYLuDdHp3tmtJPiQWfnWcOuwSUyfoLEF2A/2CzX0EH+
 RKlagYlG2jtAfZ0cyNiEKeuMbKYA0L9S2tV+9eN7OezGQQXLQjMYW83xMyMmjwZseYev
 R4pMOKckSpgkcgQhNEf6kp+jJCTACU2tqBo/5ymbno4EP+Qwi4hLwPtTGFkgzZ51B5Bb
 E0HICtFRm8Ji2nLa6BVhGrhB4/c+a873/TUEd+N8WCcjZF0eJp0dsYRUoh4kjE9LQ+BR
 uJASahL0NLE3tC8Dz1v8lhK3VCZq8zUyOjykqxpTfZ50iE0oljs5AcUsONtqxwn5QAvc
 hlRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736248725; x=1736853525;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hoznFOBSphqP4gcOgEi27/LzCX1DhAknL37Btcf9VZ4=;
 b=vbeY+wyi1qGkKPP6Shf5wUu91qKaGJ2gUlaRSgHjatQIhsYmZazdNCya3FBM0qzF0v
 OYWJL+K0H9ddJTx0AXsvfXxUm6qQvbF/SprbwVUfcRAUQa7bBBsjZA2roWWRNlW1qxoK
 Ee2af9xCpqwTsNpeccGaAbVf/lR7x45lx2EfT/iGr3Ax+5QR6oAkvuu1oQZJgQgI7xxQ
 +luohm9Cg54QFnu758kSoPH/XmQjQTMnQsYJ+FPFK4REsSHaV2BnmBolldtvHqikAEvO
 inDRoBc7DndywqBS1fR5zp6GP58nn8FKbNWIR/vrdbxnJWUoz4qCBuYKHy/MMq/uL5jj
 8S1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg67sQNy+9bkCwyugkQJKODGOFDMhKDf/QSLN/RIcX7DhBrTA4rTpD0WZVMrXiEfefbzyLCdCs04gA@nongnu.org
X-Gm-Message-State: AOJu0Yznfgg9nimWiZev/baHeG2aXGyor9wmvvpPYP0eK2ZYTJeVdqjZ
 m+1aZaUwGOqYntrn45WA/Wolz1B/7/xbNn8bw5VPOHTyfbM+hqJzk0w3nVHs8d8=
X-Gm-Gg: ASbGncuNgiTGvhuElRESWLY8L7JD7GvPylwIoMpRQxllIwk5xXSYZe4VvWe+IV4oXS4
 6ZvMPC3gUA5b9Lmq2iwI+rVqpxQUFXezJDUb/vUaUraLGzxB8/BDjrZrqX0V6ComffcVWCCf7Eh
 vL7FUK3sS3AIInk76Iuawhp4NLQ9kX37kmY7kaJidcau3GKRXDRs0YI8vAiaDIJEJdnpqPjMgFw
 1zKEqrtK6v+ZPj2UhXomB3pOiql3rJfCpE+antzUDNPSwGWqYfoBPMERr0y7MQpsJQ=
X-Google-Smtp-Source: AGHT+IHD2FAOOr614XE4fHS2GjK9JTPzZjPoVTKFeHxvxEPkgbMFxH1ik6O06goT/zWrsedW2jc9sA==
X-Received: by 2002:a05:6a21:7898:b0:1db:eb82:b22f with SMTP id
 adf61e73a8af0-1e5e0458de2mr94005899637.5.1736248725318; 
 Tue, 07 Jan 2025 03:18:45 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-8e2478b59bcsm18614741a12.72.2025.01.07.03.18.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 03:18:44 -0800 (PST)
Message-ID: <015052c8-969a-4604-b2eb-aa6ded0f4331@daynix.com>
Date: Tue, 7 Jan 2025 20:18:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: No display in Xen PV guests: "This VM has no graphic display
 device."
To: Dario Faggioli <dfaggioli@suse.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Durrant <paul@xen.org>, Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Charles Arnold <CARNOLD@suse.com>
References: <23260a79710e2c302028afa401a969ca9cc389f9.camel@suse.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <23260a79710e2c302028afa401a969ca9cc389f9.camel@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2024/12/12 0:27, Dario Faggioli wrote:
> Hello everyone,
> 
> We've found an issue that manifests in Xen PV guests. We have
> encountered it when testing our (SUSE and openSUSE) packaged version of
> 9.1.x, but I've been able to reproduce it even using the upstream
> master branch.
> 
> QEMU 8.2.8 works fine, so something happened during 9.0 or 9.1
> development (and not backported to stable).
> 
> Basically, it's enough to try to create a Xen PV guest with virt-
> manager and the only output of the virt-manager window will be "This VM
> has no graphic display device" (while, e.g., `xl console <domid>` works
> fine).
> 
> There is some additional info in this bug, but not all of that makes
> sense (we were in a hurry for a fix, and this is not my area :-/):
> 
> https://bugzilla.suse.com/show_bug.cgi?id=1232712
> 
> However, what I eventually figured out though (through a couple of
> bisections), is that if I revert _both_:
> 
> - 6ece1df966 hw/xen: Register framebuffer backend via xen_backend_init()
> - e99441a379 ui/curses: Do not use console_select().
> 
> Things work again.
> 
> As I said, this is not my field, so there's not much more that I can
> say for now. Nevertheless, I'm happy to try to help as much as I can
> (e.g., testing theories, trying patches, etc)... So let me know what I
> can do. :-)

Hi,

I tried to run Xen on QEMU to debug this but it doesn't boot. The 
command line I used is:
qemu-system-x86_64 -nographic -kernel var/xen -initrd 
var/xtf/tests/example/test-pv64-example -append 'loglvl=all 
com1=115200,,8n1 console=com1 noreboot console_timestamps=boot' -m 512

It gives no console output. Do you have an idea how to fix this?

Regards,
Akihiko Odaki

