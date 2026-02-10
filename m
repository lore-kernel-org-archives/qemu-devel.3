Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38D0EA813A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 15:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpq3X-00027D-Q1; Tue, 10 Feb 2026 10:53:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vpq33-0001eW-NB
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:53:15 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1vpq2c-0003m9-9l
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 10:53:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1770738662; x=1771343462; i=deller@gmx.de;
 bh=7vVmmefgN1ZJ3H21h3UQrXUB6mMfRO+z3+O66cOk3r4=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=jr8smEiQmurqGMZUfRpIlNioZn8K5fyZkS2FDLy9LgMDwjN0A5kcil1jTfKQU3MU
 kfL4nkyGEejiOEtxtqAxQWuYXxbnXirqnsEwnaGUNJIpE3erhYFaTpKPU0guvkpWH
 YH5qyRQDyshnCXS7qs6RxFWycT2eZGL7jp6NBUSmYr4jQ8jKBiZztCsKoKmmzFugj
 7aLToopCIEgxr3pdHfv9gmzfou6CAIAgrC2ny5GkHCdr0JkcbqJI3tbGoQDpw9pH8
 LV5clqyb9++8v6wx36B+YRSk/El6gr3llYz5aQft6PpDUYb7sBdqitOB/Hfm6FyDT
 oc2g3XQOsmKKBj7Fhg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([109.250.51.36]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfpSl-1vIgzn0ta5-00d2pa; Tue, 10
 Feb 2026 16:51:02 +0100
Message-ID: <62f5f22b-dc5d-4fb5-a968-ebfe6d9ef967@gmx.de>
Date: Tue, 10 Feb 2026 16:51:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: fix matching ioctl numbers in print_ioctl
To: Andreas Schwab <schwab@suse.de>, Laurent Vivier <laurent@vivier.eu>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <mvmldh19bja.fsf@suse.de>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <mvmldh19bja.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fubB1+dg7dgQiuweFTXCgrelNvMgRYTIFUAZlIM5jek07coAe9t
 P/npBv7s1OuWtq7VXRSdYMi/L+rX45DpCwJbQETh2pY8xql0A1roItclUxRB99IqGrrQK0O
 nwY9wMlH96gOsAMm9/H/rryruttFPt9XAsnzTvMKOY3eWTQ8gwWLHwFpVORuREF5r/wTGWD
 HLEZn1be9RMnidknnm+hw==
UI-OutboundReport: notjunk:1;M01:P0:f5Alum9Ivdc=;Izk9xFVjTj0PQfIzlytLmtuAznA
 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
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/10/26 10:46, Andreas Schwab wrote:
> target_cmd in struct IOCTLEntry is a signed int.  Make sure the ioctl cm=
d
> argument in the syscall is converted to int when matching, so that it
> works correctly with an ioctl cmd that has bit 31 set.
>=20
> Signed-off-by: Andreas Schwab <schwab@suse.de>

Reviewed-by: Helge Deller <deller@gmx.de>

Helge

