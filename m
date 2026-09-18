Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FBBC88E75
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7SrZ-0002x7-Cu; Fri, 18 Sep 2026 03:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x7SrU-0002vS-NO
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:18:21 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1x7SrS-0005Pf-0C
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 03:18:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1789715893; x=1790320693; i=deller@gmx.de;
 bh=5/5LYNb3AqiirutStUOas3NyEDn8y/1SHhXZDYUGMp4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=U9dJib/zWXTojXD7/gkbxOtFWQy/CE5CrJMX8vtCRKWZJ2inEr8RiHnh+Gt/gkt/
 J9zIDwVY5n58DeTNT4mLN+OJQlTMTl97wWboFEYZBKQD7vBsvOiWK3ALgi9kL5RLd
 KlfQOls9VHf40RHmnjD3LMO04y2puJ7bCkq9QjXB0tyLJARGs4PZuIGLGzEl1RUWp
 AyumLcS3wjTmFYZg32imLTouRVYlVPUtW5F/ntwePYRd2Yg5LJNTJHBxfYAZT2b3Y
 +i3Es8INShHTTTkjHc/DZ96bnZ4ZkcE4uKyF+DTMCxobr5Ec4uJd4WHqcSh41IQMR
 R7bxgP9OSG8LDb4BAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DNt-1x4RWW30sH-00581g; Fri, 18
 Sep 2026 09:18:13 +0200
Message-ID: <309c1091-6504-4318-bb21-ec9c1d45bc0d@gmx.de>
Date: Fri, 18 Sep 2026 09:18:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hppa/tcg: Always initialize DisasCond.{a0,a1}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260918004132.365434-1-richard.henderson@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20260918004132.365434-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+ps+tUPIwrj8/ysocnIsaScMIgWuWQ2Y1KOjsvmevPUOYTguaVE
 Qgbnh7p/K8eXVEt5TTuMYH6zv0e4am9FCkOfJe5g84yjwTjy6OjnKYFL0J5WA0141krxOr0
 oZROVV0afwSssWfISkwCqdlTUk3t9Fh07kJqlsxK5Y3zWFgUWXsgVPABLoyO0r7TUSAENgF
 occ5qeX1OgfliU0/9qENg==
UI-OutboundReport: notjunk:1;M01:P0:bcP23y2iySs=;VuGaOQvVvL2QTkUoOWhx6nmUWJc
 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
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/18/26 02:41, Richard Henderson wrote:
> Forthcoming tcg improvements will diagnose the passed
> null pointer with --enable-ubsan:
>=20
> ../src/target/hppa/translate.c:579:9: runtime error: null pointer passed=
 as argument 3, which is declared to never be null
> ../src/target/hppa/translate.c:579:9: runtime error: null pointer passed=
 as argument 4, which is declared to never be null
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 72 ++++++++++++++++++++---------------------
>   1 file changed, 36 insertions(+), 36 deletions(-)
Reviewed-by: Helge Deller <deller@gmx.de>

