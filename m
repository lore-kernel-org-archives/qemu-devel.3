Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E03AAEDF160
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 13:28:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqtDP-00053p-FP; Fri, 13 Feb 2026 08:28:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqtDL-00052q-TE
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 08:28:07 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vqtDJ-0005gZ-SS
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 08:28:07 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1770989273; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hPurw4dCfkzZ6jEML4R50YYki4/QalMiHpcXoSFroAg+ZazRr2GkvmRR09VY4eRRWDmWopitXxLTGEPGybKYhSyYs0Zo1up+EjFgN3PYjfJJ4ICEEA310yD9d3r9R05n/jhGp35WfSDNr418CUNHJIcLKPwcF4sYotvy09u6KQo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1770989273;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=vhz2A7MAoDMgNI2GI0nsWIsbP845ukBdmlE993GBckY=; 
 b=k/Nufwxf1XuB3W1HHCKBCuHVyOMtsGgKR4uptdEIJtL6aj7sGOWRH6ftLDcPKALbOLhqxB31emx0XeGOejPax/4OQK+SvYesgWU69Jc36Q/XeyorbT2y4Lt+Pwlw+1bA0mN6/0qy3lEV27KcRiwBs1xnk1gqo1/8QbLirovliLM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770989273; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=vhz2A7MAoDMgNI2GI0nsWIsbP845ukBdmlE993GBckY=;
 b=Rk1ElsxqTPFY/7g0Xr0ZfHqGKFLbFpAFY8qW8qQ3+5cCdlqik4j5mMHrG6F9Xy7Y
 VwicppGUnwYB22qgiiy9Upat8mLt0jWsTxXlbbqc4A7n6nSR15qrdJe+NEBdqiIeAqO
 /egHFP4qKO14z7QryHfCYKEKg3BaTiV7+kxoc/CI=
Received: by mx.zohomail.com with SMTPS id 17709892715741001.3126697409612;
 Fri, 13 Feb 2026 05:27:51 -0800 (PST)
Message-ID: <cadea0e1-4727-48a7-8fe2-ddf52809da6f@collabora.com>
Date: Fri, 13 Feb 2026 16:27:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 41/51] virtio-gpu-virgl: correct parent for blob memory
 region
To: Joelle van Dyne <j@getutm.app>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1770231744.git.mst@redhat.com>
 <81cb15cf3774140da7c17341018a3852f920acb5.1770231744.git.mst@redhat.com>
 <4eb93d7a-1fa9-4b3c-8ad7-a2eb64f025a0@collabora.com>
 <CA+E+eSDta5wSBs+=iuPm9yzFnxRihrOmeXrDSVJYoAAiYNQ9fA@mail.gmail.com>
 <68223045-effa-4319-817b-1a31f227c081@collabora.com>
 <20260212020117-mutt-send-email-mst@kernel.org>
 <f6d75a31-a72c-48da-a195-0a74b75b8596@collabora.com>
 <CA+E+eSCu93wwd_7EZ3ekjDj+URoNT+3YBJvPARfwB3xnj04EQQ@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CA+E+eSCu93wwd_7EZ3ekjDj+URoNT+3YBJvPARfwB3xnj04EQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/13/26 02:57, Joelle van Dyne wrote:
>>> applied one was v3 according to my records
>>> but if it crashes pls do send a fixup.
> Sorry for the confusion, I was traveling and when I originally
> reviewed this thread, the stack trace + the link to v2 caused me to
> claim that it looked like v1 (since it didn't have the NULL name
> change) but after looking at the changes properly I see that v3 was
> the patch that was picked up. There was no mistake in applying the
> wrong patch.

Indeed!

-- 
Best regards,
Dmitry

