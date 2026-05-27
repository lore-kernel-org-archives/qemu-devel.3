Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 849F0CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 20:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSL1I-0001wu-KN; Wed, 27 May 2026 16:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSL1G-0001wb-Qo
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:38:27 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wSL1D-0008W2-7O
 for qemu-devel@nongnu.org; Wed, 27 May 2026 16:38:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9B956C0483;
 Wed, 27 May 2026 23:38:15 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:69::1:d] (unknown [2a02:6bf:8080:69::1:d])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp) with
 ESMTPSA id Ecg2rA0aBKo0-C7wdBAt1; Wed, 27 May 2026 23:38:15 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1779914295;
 bh=AZetjL7ITEGPaCgK19pxpYzQMI835TQIvvc4gIGufew=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=hMY/A/SCzyOKEP0jVS9UwC+GalSdjXW+S0U1GTsZajxzoW//yu1FkotL2uZ2hTuDD
 ysi8/GbbkHXHch+P+IH/M0yh+pwNG7qZ+9mZMWsSRTfCfxsJYmheGd/Z6C96zRbAd9
 KsC//FIJtpRt3GHKq5zdh7QizT2vNy4EVLIwle5A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <fb47888d-ce33-4380-a477-f17491d6c430@yandex-team.ru>
Date: Wed, 27 May 2026 23:38:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 5/8] virtio-net: support local migration of backend
To: Peter Xu <peterx@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com,
 armbru@redhat.com, farosas@suse.de, raphael.s.norwitz@gmail.com,
 bchaney@akamai.com, qemu-devel@nongnu.org, berrange@redhat.com,
 pbonzini@redhat.com, yc-core@yandex-team.ru,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260522120534.77653-1-vsementsov@yandex-team.ru>
 <20260522120534.77653-6-vsementsov@yandex-team.ru>
 <20260524050632-mutt-send-email-mst@kernel.org>
 <c34e9bba-0e98-4694-870f-5f92f34f1076@yandex-team.ru>
 <ahRgbmVKuonjprB2@x1.local>
 <62045016-a892-43b8-87b1-869ef8d8e9d7@yandex-team.ru>
 <a572dadb-6ea6-48f2-a77c-3a4531dbad49@yandex-team.ru>
 <f84de0fe-8c93-4c3f-ad05-de40410b4697@yandex-team.ru>
 <ahdI7Vl5KraK566D@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <ahdI7Vl5KraK566D@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 27.05.26 22:41, Peter Xu wrote:
> Personally I liked part of your proposal.. normally I would rather leave it
> for later, but then it means we will be stuck with this incoming-fds API.

I am OK to mark "incoming-fds" as unstable, to simplify future rework,
if there is a good solution.

-- 
Best regards,
Vladimir

