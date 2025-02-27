Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89286C021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 01:44:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnSxC-0003KA-W1; Wed, 26 Feb 2025 20:44:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSxA-0003FO-KU; Wed, 26 Feb 2025 20:44:46 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSx8-0003o6-Rn; Wed, 26 Feb 2025 20:44:44 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-219f8263ae0so6552775ad.0; 
 Wed, 26 Feb 2025 17:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740620681; x=1741225481; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BNOx730Rq2j2aQ/QJoqhbs7KLKkgBHPCzejEJsUnnzI=;
 b=nMINbEZhX0KONSRAzwj0og0u6LB2s1S2ZuethQ6QRQv2yzMH/BcGyW5/2wa5e305Hx
 +eS+p31yO5RrRTC9XcAO5wjalBaU+Fzg6Ate+K7TYhbe3asgHYpSsxB8aFjIbhB6MN3j
 Hy3ijD4aP2gRHCY7Wv0Yexx09DhD5lQQ6XKqjbeMYmjIxOLJFtQNWX4pxZ2nTz4yIj+x
 AoSdTiqKKeJlaZ03K8UzgttnvO7jg/0sXVKodphcY7m9N9UXiPVZms+Q4vGXCM0WzUyE
 nXzJcgfw/oV8l5PJHh8wBhFubNAtW/2xB8vsjPbrzOpJTRoeeIezcOveKei5tnYYMtFp
 OowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740620681; x=1741225481;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BNOx730Rq2j2aQ/QJoqhbs7KLKkgBHPCzejEJsUnnzI=;
 b=UGnQJCqzWI4iKeoiB5KuGxL9hUmQc1vaB+WwFgzVOsH/8C5pvieAXPAQrPY4Z0h3LV
 UullnLPr/RVLEABUWeUXjPb0NNhBvitpIgduz10OIZCrLu8FVLF1ROj/ADaQwUusptsT
 9if47I6AzffZWr++tGFRF7K9jm/pALFThMmqdbjqvoy16vqJlXAzCI2SSauM4hxp3Fei
 oWsny1U+ayVHgNgEcbFww+gB/Q30SsDGm/9JIZReqoRngTed4NG/NnAiOwxfbT00VIxe
 QJD+JFD8T6TlkJDNe4OQCT4N7i9vXVD6174DZXLBomU2HSX6TafjD+/33hehutT3xoPG
 tP4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZy3lVd7vPW5gBNKLgXs409n0Clsaiou9DPUwnHvhu5P4G5EojKrhQ/J+JtrIpVcDGiy9TaSK5x/Fu@nongnu.org
X-Gm-Message-State: AOJu0YyDk7OlnEwlbeg2Jk5TcL9sJmPPG/WqyItbrIUPaHR2K1WV/5a9
 LrXGPxkbQbXhjtBw1lFHvAO6Zz4mcUMS5z4vNLmkwMCLO6jIXvzH
X-Gm-Gg: ASbGncsJEz3SkuDRTs+oK+roHy85dskSQ5Hnfp27Le4HXLGH2WLPnp2MFq7OWWOzhwj
 Ay2HN3m4DUOOjczq84JMYZyFXlHVYMhIzx6+0tdnsETEe0SEK7DPxLcbYMM+jMQ2RP52R7LOh/o
 R+EDPOiKPoc6hEKTMbw7zRGequxbZYa/Dz/4ZK+5bNjzm0xIst/D6dhrSVep5asVdRBqXK108lE
 z1weW15k9ShpppHzC/Y3Xe1JzuQZb+cx7gh1+yB+3mpKimbLJ5l7sf+7XrRbkJKzVVfYtiWWJMe
 O8EnGl3czKa2uO/yrA==
X-Google-Smtp-Source: AGHT+IG+KhoFizqd7AuBIcTCV7v08DIWhgaPXyLJs6JfLcxlx9Nyl1AiROlyrobmfdzrV3vF4a24Ig==
X-Received: by 2002:a05:6a00:174b:b0:730:9424:ea3e with SMTP id
 d2e1a72fcca58-73426cd90a9mr29944452b3a.11.1740620680933; 
 Wed, 26 Feb 2025 17:44:40 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7349fe6f066sm284614b3a.83.2025.02.26.17.44.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 17:44:40 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 11:44:33 +1000
Message-Id: <D82UJ67OR69T.1SJ7BLFG024HV@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <clg@kaod.org>,
 <calebs@linux.ibm.com>, <chalapathi.v@ibm.com>, <saif.abrar@linux.ibm.com>,
 <dantan@linux.vnet.ibm.com>, <milesg@linux.ibm.com>, <philmd@linaro.org>,
 <alistair@alistair23.me>
Subject: Re: [PATCH v5 2/4] hw/ssi/pnv_spi: Coverity CID 1558827: Use local
 var seq_index instead of get_seq_index().
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Chalapathi V" <chalapathi.v@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250103161824.22469-1-chalapathi.v@linux.ibm.com>
 <20250103161824.22469-3-chalapathi.v@linux.ibm.com>
In-Reply-To: <20250103161824.22469-3-chalapathi.v@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

On Sat Jan 4, 2025 at 2:18 AM AEST, Chalapathi V wrote:
> Use a local variable seq_index instead of repeatedly calling
> get_seq_index() method and open-code next_sequencer_fsm().

Oh... one other thing, this is no longer a fix for CID
1558827, right? Just need to change the subject to remove
that.

Thanks,
Nick

