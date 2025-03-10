Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8952C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 03:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trU3m-0005Pe-Mm; Sun, 09 Mar 2025 23:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trU3k-0005Ot-3U; Sun, 09 Mar 2025 23:44:08 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trU3h-00017G-Ja; Sun, 09 Mar 2025 23:44:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223a7065ff8so52018065ad.0; 
 Sun, 09 Mar 2025 20:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741578243; x=1742183043; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cd929fU5g3wK32OwmkWHXbxR6sgCaf/WTkW9sgkKymk=;
 b=VhZvqCRaJkeGUwd52A5YZ0XaLhdvHnbCBwFCb704r8mOZ3W4Sqt9Y0zpcluWkrueER
 Qg9lM4uxxoRLwKrIwr+UIp8WYSUklsM5pDnPyt8vAgBukXeVZAHvbMR04lCnmi6Z4P6x
 XZVe2A0C6hvBHktVYqhyIvghKrFnipyxJYhMAKQ50ScqYOdgcJoFZgR3is04ovRFfzNI
 9EFhmgzOiDVf5N1F73owVL1XsZDUnncPtXjupJJblzhr/fc9HUBCkkStG2cR9uuJmBiF
 SmRH7ox3gd8zhZxsiA4qqYE4YRs7kPGQ8lBHUtKdvtlGuKQV/+381HiNXchYjaoIv3Ha
 /UHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741578243; x=1742183043;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Cd929fU5g3wK32OwmkWHXbxR6sgCaf/WTkW9sgkKymk=;
 b=pVpuB3fa90I5nIeMTBin02yGD/VibK1J3qpc3l2oLJTGKh3ifJ6xUXVYl7QzRlH8Cr
 IN09wri/MQYzD6Ya0aEX4KPjnnTuJ+nmB+XzEO7OoqBXoPmyUa9EJ3XVAb7KJDmmThB4
 kRI7bIvWuGpWvyI4/0KZTrGnmnVXl93YcwnLTcXYhNSkPoWwV48mF6uY4oibymB1+UVG
 Wfd2karbW7oBXEYlA6n2G6N+L6Ovdg8xWvupp7EeBWH0Lv5lpI6TlC87ovnb4cWTKftM
 5eglExWVrNN2fBIu8A7/ttli5/2k93BzthQAeLC6XtWE8s1WH7If4xPkSs8blkgdM+Ud
 nc3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4HoApVi5gaL5JO+f3ZsJ8chE4RhJBmfc8ZT3UdekWZh8cD8bhPMnGHz6P35nK0eID2fV5CHM947rb@nongnu.org
X-Gm-Message-State: AOJu0YyeHPWk9YkULBpk9qP9wLS3NtCCWQ1cNzaLmvg+rx7VzspE/PNh
 ZPdihN8fIxMc5GwfUsqXTfYIvCCODxQIrhvQDai3t8XTKpzardRW
X-Gm-Gg: ASbGncu/iM04OXqVceW/IwP0DGn3hF6uJ5KlNetZjWVcX8FmyQ57MyQCSzFV8AOdUqz
 v4+aanKccReKsnyycZVBPmmBswbmqpd4Vlusxa1OriBVeLucy3dEKbcVEEbhte7xCHQz8o5zk5f
 f+oH48/i8hrviwA4gl5GVelH5tbjYJQZS6/TRYyCEs/mTY8/DRvMw3SS7BcS+7csU5S6shiYksE
 PUiWLraxV3bfal7mPbVGs3rS4JwRMokXFzp4PKLNyx8whUaiChPW+M9NaphTsgwbSiM02kpzlBf
 R4TcinZh8Oxj40BE1lZp3cQi8S9uIpWFLPK9rUiT2+xemUZQUIg=
X-Google-Smtp-Source: AGHT+IGUGm6Fe3FjXn1MABknzaXjSWpQ0Z/CpE0bO1/HmVUBA6ddRAR69ldM7MiitgyMSjt8ODKWvg==
X-Received: by 2002:a05:6a00:4b4a:b0:736:5c8e:baaa with SMTP id
 d2e1a72fcca58-736aa9bc0e9mr17523057b3a.2.1741578243430; 
 Sun, 09 Mar 2025 20:44:03 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736c11ba2cfsm3353416b3a.122.2025.03.09.20.43.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 20:44:02 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 13:43:57 +1000
Message-Id: <D8C9YKZJ15BI.12G2MRXUIPQYS@gmail.com>
Subject: Re: [PATCH v2 03/14] ppc/xive2: Add grouping level to notification
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-5-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-5-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
>
> The NSR has a (so far unused) grouping level field. When a interrupt
> is presented, that field tells the hypervisor or OS if the interrupt
> is for an individual VP or for a VP-group/crowd. This patch reworks
> the presentation API to allow to set/unset the level when
> raising/accepting an interrupt.
>
> It also renames xive_tctx_ipb_update() to xive_tctx_pipr_update() as
> the IPB is only used for VP-specific target, whereas the PIPR always
> needs to be updated.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>

BTW. the series went a bit out of whack, I suspect because of an older
iteration of patches leftover from a previous git format-patch, then
git send-email *.patch picks up some of the old patches if they were
renamed or reordered.

Don't worry this has bitten me before. Would be nice if send-email had
some heuristic to sanity check metadata in cover letter and subject
lines to warn about this...

I think I've been able to untangle it.

Thanks,
Nick

