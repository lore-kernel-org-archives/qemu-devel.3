Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FBAC5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2lp-0002jW-JV; Thu, 20 Aug 2026 09:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2ln-0002eL-RV
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wx2lm-0003q0-D6
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:25:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787232321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SAeWE8WcMGRNyFCDyjEYDt+sUDsvtOQlL5Y8U4dqip4=;
 b=Xzot/w938Prj2rTO3VAa/ZqqDjPiE7WDr7exiqmDXwGGKt/SjOCces5GimNdMJYWZMtclT
 ZELCRd0BJ1kgNmPGG3jAYN8H3sHFXcTSrQaeVn7SH156AtYXxZhVose05bkRGWJo/+NLPW
 4rKSHkvxIAqB2vZZgS6YwKJe9qgO+7E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-376-oRb618dUOTu3s-iZk6-2Hg-1; Thu,
 20 Aug 2026 09:25:11 -0400
X-MC-Unique: oRb618dUOTu3s-iZk6-2Hg-1
X-Mimecast-MFC-AGG-ID: oRb618dUOTu3s-iZk6-2Hg_1787232308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92F49180075E; Thu, 20 Aug 2026 13:25:08 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6214F180034C; Thu, 20 Aug 2026 13:25:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH 12/13] target/mips: Constify CPUMIPSState in
 mips_vpe_active()
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 qemu-arm@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Aleksandar Rikalo <arikalo@gmail.com>
In-Reply-To: <20260820104730.25462-13-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
 <20260820104730.25462-13-philmd@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 17:22:15 +0400
Message-Id: <178723213515.2730041.14256372650765958415.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=331;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bQRLXB1KN9bbv9wr/PUOMO4fTtN+Q59qPCrvSBVYVf8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhv/rZBNblqxDczd4+NFT/FPmNBM5E4Fhk2QIB
 TLrL4xQj9SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaob/6wAKCRDa6OEJdZac
 5cseD/9klKiQVBn4DFYvdC2UCgnWCHJW0kHGg4MrGoTFOZJQabddkdtqDNuke+NlKelE7/QEEfg
 bnMnbOP5CKo1WYDJ9Dr2EmJ8xE1MzemtLnMmmtagFWvX5WHJ2q1SMtyLNLrZAxNh0klYzmUErnz
 kt9laGZy1lHtJyinjqIUVKJyt6R42DkL6qthYuKgG9ct53sjPBjpyq7HGbKvSgvnDxVZT1+xUKC
 znfe3I8WO3Ixaw3sCuZrpk3JB6WVDu9OjzfvkeESdB5z33hl4SxPh5iHJxcKmInP7e8yo+YxDsS
 0UWJnsXkWtArSjbUuYRQHpnSiZgu1BUcM75lMNc80eS1uVcFIa1CZf6bVPvXurZ/NXR9Nbpjni4
 QNz9uBvrbb1sk0lNR2UQMrDK7BT5UzTU9Yt947EetFdXD112S8CZMTESk8fuXdma8pw/kGKpKyJ
 l2knpk+HvnqHJ/vBojH569shvLpuZrmHt4KJX7LyNDV3kYbZMBuHMHvlIMhhRyX7lWmWYOMd5vM
 X8w6/FEg7BlF1wTBO7+zCWojv5rOFl/AL8+sKABrry/d5k6A5ZjlyTNNQ0Rd0LadtwptxQbGgGE
 voQsdvsw0o35IcIZhvXhDHVMDHzX0qk36wcE6Ag6X3rtnYh7n/54IQz8/qM91uSBt0WdyrWSfGb
 sKk/POe+XSBIhBg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 20 Aug 2026 12:47:28 +0200, Philippe Mathieu-Daudé <philmd@oss.qualcomm.com> wrote:
> Use the recently introduced env_archcpu_const() helper
> and qualify @env as being const in mips_vpe_active().

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


