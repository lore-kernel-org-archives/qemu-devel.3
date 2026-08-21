Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A4AC5DF81
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 01:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxEDz-0003O3-DG; Thu, 20 Aug 2026 21:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wxEDw-0003Lx-K6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 21:39:12 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wxEDv-0002Ez-4g
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 21:39:12 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3811f512167so551783a91.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 18:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787276349; x=1787881149; darn=nongnu.org;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XfNtGnk/NXATgtXqNnh1LpuC8UG3TYcVBjKNZq160rM=;
 b=mDPZDWLt8FmhJorgzekwuT4Gr+trIVZscAA6QPbsPQDhF6DQ8B8SnlvGeZfHpqUgBh
 i4HSZcskG6ayIE6WLQG23J8hRtmlq/23xQOcTg6iGNtWvugELluyRxFNXVD6detwMs+v
 qkTbHHhUe8PvNTIEdwuyXp0m9QnlwLmLLzeDP9BiNnDXf1IqPHrd8Y4kcfOnu4q/L+no
 rWgaZSr6E/LG/9NO7lraW6ONVE/tCyPxHBopcwwokCXghmnBmepRQurGV7B/sgw6saNu
 lhNquHzVsfSYP6kuh42LrDaRZosec6fnqf7zVG4yKbriCt4hJjAAVMn5jxPPcpcXg1va
 diTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787276349; x=1787881149;
 h=message-id:date:references:in-reply-to:cc:to:subject
 :content-transfer-encoding:content-type:mime-version:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XfNtGnk/NXATgtXqNnh1LpuC8UG3TYcVBjKNZq160rM=;
 b=GPehS7f+j8HvmEqXce7pZXIW2wZiwMTSMatXHh2ACqOq5DZwQ4Oi4IdC5BU6cXL/bh
 FgH+c5PaT9BVp1Ca/evQ5WhO3+ZxZ5Z3V4Vpq4gvwojAo7JohxOfL8TelT+GMIiUCCzN
 eX93JhYoRjCqbubw5DXZZsBYnTUe90lI5nmKhZCBKvMrIRRYX4QcyVQLxhJTELDS4TQ0
 7bgRwdt7Cu1rqOB8uPFMxxIjZw91hwTn2uhMRDbVMT1Tamn6QDMlhnrp7lLhd2wEsUMs
 hrvwNz2xPMixR8zh+/JQOI+173yNZoEwdTgcO6zwUW9X7yoV+XjvUil1QOcWGwW2M/dn
 E6cQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpZL95JjFkkPuYtiO6ENCzgBrPBRZCxCe/lOL+ZglAu3lh7boRfclF3Ae+Mj7Udq/TON2Zvp+6eUHat@nongnu.org
X-Gm-Message-State: AFuF++l3uLicyB2DhwGCvxdKvxblFNV/qnkmjU+TCALWY6iPc4Vb8NhU
 /Gh+5rIla8bQqMAfs2XpMW/5NiH1Vw/0U/poJ/mPyyfuXE7XTqK1MJYW
X-Gm-Gg: AR+sD10Oz8/K5wx8gk9cWRfFsQD5GtKd64RctZOAI0Nj6v8y7+47jLpRsEi/62Y1KZp
 IrG1IgyHnz2NhIcRNvl8W11IcAlCFfiMcYNKUFvdWAC1A1yfzyd7YL3JzG9bpZ8kXbvkfsgsuzj
 w3d8dom0TSCYl7/0CFcBc9RswTvgcm4oh4KjXHFn/AKjYdNXS3ZPMV1hi/zyLxk4rjYgY6x6mVi
 hb0OUDp2IjLFwHIWyUMmtGj2ulI3SJ77zhQE7iBGF9KLaZ99bO5hc3ljJ8zzBsjdHLAa3PT9R70
 aFQQ8/rdVuOEwURPeVq6SEaa1TA72okDRdJPHQW9Xsa3U3qD6+U/qieX/Id3K2oesTeZfgam0Ha
 1LP/Mu6THDLZ0tydwDfUtRvIz7DNYONnbkq9Cn2rObnR8KKZ3jwvMres9sAPRfQukUor3euSyBS
 phclAqqCBFsW+6pa1+QldvLvS3Km9uF4k8OLG3r98QNrFk45AO+Yc+h+JBkL7DA4SS
X-Received: by 2002:a17:90b:4a81:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-395c34fed98mr4132889a91.4.1787276348966; 
 Thu, 20 Aug 2026 18:39:08 -0700 (PDT)
Received: from [127.0.1.1] ([211.226.54.223]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c4be666bsm981873a91.11.2026.08.20.18.39.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 18:39:08 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
X-Google-Original-From: Jeuk Kim <jeuk20.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 5/7] ufs: Make the logical block size configurable
 and answer absent LUNs
To: Mikail Sadic <mikail.sadic@ibm.com>
Cc: clg@kaod.org, peter.maydell@linaro.org, pbonzini@redhat.com, 
 ninad@linux.ibm.com, titusr@google.com, jeuk20.kim@samsung.com, 
 philmd@mailo.com, steven_lee@aspeedtech.com, leetroy@gmail.com, 
 jamin_lin@aspeedtech.com, kane_chen@aspeedtech.com, 
 andrew@codeconstruct.com.au, joel@jms.id.au, calebs@linux.ibm.com, 
 milesg@linux.ibm.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 j-young.choi@samsung.com
In-Reply-To: <20260813193040.669533-6-mikail.sadic@ibm.com>
References: <20260813193040.669533-1-mikail.sadic@ibm.com>
 <20260813193040.669533-6-mikail.sadic@ibm.com>
Date: Fri, 21 Aug 2026 10:38:44 +0900
Message-Id: <178727632471.917875.11234291271056551201.b4-review@b4>
X-Mailer: b4 0.15.2
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1029.google.com
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

On Thu, 13 Aug 2026 14:30:37 -0500, Mikail Sadic <mikail.sadic@ibm.com> wrote:
> Two things the ufs-lu model hardcodes that hardware does not.
> 
> The logical block size is fixed at UFS_BLOCK_SIZE (4096), both in the unit
> descriptor the logical unit reports and in the block size of the scsi-hd
> backing it. UFS does not require that: the unit descriptor carries a
> base-2 exponent, and 512-byte blocks are common on real hardware and in
> images built for it. Add a 'logical-block-size' property that sets both,

In UFS 4.1, bLogicalBlockSize has a minimum value of 0x0c (4 KiB), and
READ CAPACITY explicitly states that the minimum logical block length
for UFS is 4096 bytes.

Do we have an example of real UFS hardware exposing 512-byte logical
blocks?

-- 
Jeuk Kim <jeuk20.kim@samsung.com>

