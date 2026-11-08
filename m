Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E295F606A322
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rispop.dev header.i=@rispop.dev header.a=rsa-sha256 header.s=protonmail header.b=FT4tbZQq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPwsS-000498-LR; Sun, 08 Nov 2026 01:59:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xPwsR-00048l-FN
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 01:59:43 -0500
Received: from mail-4317.protonmail.ch ([185.70.43.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rishab@rispop.dev>) id 1xPwsO-0007h4-JZ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 01:59:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rispop.dev;
 s=protonmail; t=1794121177; x=1794380377;
 bh=2OJsOd3RFIUbDvXx3e061SmNl8O4t3qh0E4QTvRi7Q4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=FT4tbZQqhTJ4mZmadEx5A6LyvNq+iVsx25kvtSxs55R1H4+e3iaCe14014xPCBTLL
 CwaD1eiOE62XAcbWA22ob/iVMZFFl+ytuSgIMO+YiLI+SbVm10NuSSnsUqP0g8BX4M
 oZY8i+Qm7SPbRawLK3mttJvwsv7DdXsHKsfMsSjqyhe3VNCUFAP1Akdp1RGX/3YXNt
 +yE2SjTfL+dQK/U/lfg0quWElNpihFIidl1tCuyjEAeYS1Hg/endBRRw4P7CJJPm+K
 uV98ml/CmQSk7Xi42pE+FYzUdHeO0zocl0Z8BkkjMZyYn9UKreOFTxWb5casqmkpGk
 sP+C9VIHVMQIQ==
Date: Sun, 08 Nov 2026 06:59:29 +0000
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
From: Rishab Pradeep <rishab@rispop.dev>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Tarun Patanjali <tarun.patanjali@utexas.edu>,
 Chris Elwood <christopher.elwood2024@gmail.com>
Subject: Re: [PATCH 2/2] target/riscv: Apply pointer masking to
 SSPUSH/SSPOPCHK addresses
Message-ID: <uzFNP3i3RAY7q9_C2FeV5E7WjAKCLZhq9ISY1URfmHfarFn8VxwBpvsm4OBGcU1YiMOBmrwfJ8OOzvBP5QDiqqWCE-zZHQ12krln9fcY1fQ=@rispop.dev>
In-Reply-To: <7862410f-d4a4-4316-a54a-67252cfc9860@oss.qualcomm.com>
References: <20261029183751.11143-1-rishab@rispop.dev>
 <20261029183751.11143-3-rishab@rispop.dev>
 <7862410f-d4a4-4316-a54a-67252cfc9860@oss.qualcomm.com>
Feedback-ID: 124552507:user:proton
X-Pm-Message-ID: a4a1d001ef0af686b410095dcd47dff495cb6f4a
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.70.43.17; envelope-from=rishab@rispop.dev;
 helo=mail-4317.protonmail.ch
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Saturday, November 7th, 2026 at 1:43 PM, Daniel Henrique Barboza <daniel=
.barboza@oss.qualcomm.com> wrote:

> Please add a spec reference/citation so it's easier for others to double
> check if we're in line with the spec wording.

Done in v2, citing Section 17.1.2.6 of the Privileged spec:
https://lore.kernel.org/qemu-devel/20261108064641.179764-1-rishab@rispop.de=
v/

Thanks for the review!

Rishab

