Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE64D0EE14
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 18:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNyFl-0004fz-34; Tue, 25 Nov 2025 13:59:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1vNyFc-0004dL-HG
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 13:58:58 -0500
Received: from 7.mo548.mail-out.ovh.net ([46.105.33.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1vNyFY-0006Md-IQ
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 13:58:56 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.249.37])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4dGBmD6jfwz5yDs;
 Tue, 25 Nov 2025 18:58:20 +0000 (UTC)
Received: from kaod.org (37.59.142.99) by DAG6EX1.mxp5.local (172.16.2.51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 25 Nov
 2025 19:58:20 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003c4a7f7fc-6396-421a-98b9-1664ad262aed,
 F44D14359D3F567D284CF0746F87853B98EDC426) smtp.auth=groug@kaod.org
X-OVh-ClientIp: 88.179.9.154
Date: Tue, 25 Nov 2025 19:58:19 +0100
From: Greg Kurz <groug@kaod.org>
To: Andrey Erokhin <language.lawyer@gmail.com>
CC: <qemu-devel@nongnu.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2] 9pfs: local: read native symlinks when
 security-model=mapped
Message-ID: <20251125195819.5bf1e051@bahia>
In-Reply-To: <c9461c73-fbda-4963-b96c-3fd4b2d6ce41@gmail.com>
References: <3c35955d-a57e-4203-81c5-395146e23f83@gmail.com>
 <20251125150444.5deb5195@bahia>
 <c9461c73-fbda-4963-b96c-3fd4b2d6ce41@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG6EX1.mxp5.local
 (172.16.2.51)
X-Ovh-Tracer-GUID: b7fb3bbe-d3f6-4738-b8ba-fe1c78f2a50b
X-Ovh-Tracer-Id: 18179905798617668061
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTE3arwzTQnHZ+WhN+ZhG3l9dQ9GTBOWUWKz7tRXegKeW3TDG05r9sX7gN08q5u43X06rsiRwJ6c8H3nRycuHHxNHe5Z0hZBwg+jbMW+Czkwz93JHmYtAJ39OkV6kPRxGiOmBqQ+U78WRPzZBmSwy+dG2AXLMfOl49iu0bYyI2yyGeCOgKKtMvc8EkECEXihAKcaD64nvg0QHOJUVWH/2S7Lr4mSPNkE4Q2MvCaxXlYkTNXVcnB6CfuRWxP/KT/M7MAwsts0HodG6T3A7RPIPwT8YwCGzY0xiEdaaID62C9Z3OUIVGbIl5ScWNqoKL1BLoJxgNLh+PlKgqc9j6FjUW1xcA5UbstCmSPICSk0061Iu/IZzhIp/4n18M7YXuYfnnmAxTcanrtC87RP/++7Jh1Gz7Itdc5fB56XbQ2Hztm1E2Q3ajkbc8WLr3mHy2y68NDPeX+Xgvlx0ec322TqjucT5XTkCVD//T+ceoVEcFr7bTq6j6VEYrSuyGkaKY/cqhBiBAuKUIuOIqvYsKi9ctqH8WJ1e/8Aqxm729/+4DxFrqcPVLoIPQ58uMavGTe+0rJZr8jcwVOvrWcKTlSqYuvEZxDR0Vr8AdtwnDMNzRDDt2zu0X7VkhKbfmWsAm4mELyVF4lmUhR/1zH/wBAYwoHOfIr2D5gs9gmBpOkAuInp4Q
DKIM-Signature: a=rsa-sha256; bh=W8jodKWXIN6TLg2WyWfv9ECMAkNxN+ndI5mllNQfl1Y=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1764097101; v=1;
 b=MjGirURt27SQM2i5gRFvqA5xXmlqVcNg2nkUZN2nCAN4qZdyesi5oK2xCSnRbDPr+OKLE0no
 SB6ED+g01SfAH4dT8p1R3MPA/JNSFn21FLKDfTx6DAV734cF01vfVvB6d2fczALSES6ub1Fq/gZ
 lvyIrsUGWszYXzNaboWIcBKqyAQKXKXovfSKa/kJpaOfxzHNiPOnNEVlwHOkmFIaZipl1yO3TMN
 yTvGGRwYzGEhx9vfHVitKFJ+O5IyiyYti5ClKA+/Pyn8xB0LuHxLTX+7RnBJ9utEcxbJ/7my1XI
 ObsfPdeVBSAQn+3rO1w9ikBJhciyKAf27At6a/za4zZOg==
Received-SPF: pass client-ip=46.105.33.25; envelope-from=groug@kaod.org;
 helo=7.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, 25 Nov 2025 19:21:00 +0500
Andrey Erokhin <language.lawyer@gmail.com> wrote:

> >> +    native_symlink:;
> > 
> > Still has the terminating but unneeded semicolon
> 
> I think I've addressed this in the v1 thread, with links to the C11 draft grammar.
> Can repeat in plain English: a label shall be followed by a statement. (No, declaration is not a statement)

My bad, I didn't see your answer.

It is funny that I had to pass -pedantic to gcc to get a complaint (in plain
English as well) if I drop the semicolon :

warning: a label can only be part of a statement and a declaration is not a statement [-Wpedantic]

Cheers,

-- 
Greg

