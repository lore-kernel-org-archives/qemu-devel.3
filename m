Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D0AFE520C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 11:17:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGEXN-0004ni-BH; Fri, 24 Apr 2026 07:17:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGEXJ-0004n2-RY
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 07:17:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wGEXG-0000J8-8e
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 07:17:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777029444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4O+Z+1OoIfzrmshOC2XgaPulXVo5Kfqc8ocvpEOe1DQ=;
 b=jB6GiZVXN4lAQ319EzZ9R6As34YSuWE+5NCMrObwNMLk022VSJWcj6nxc3LZd3HxeiqV2R
 naBPQEoNruuXg4RfUfRt7qXJexsMR+VBWVMmYnpCShqGejDqmvF71VftJgxxDylxir89CJ
 9TqyXN9k0eQI25LhPif3Iq4HFT3TpWQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-WT64rUxYM6SJQqrt_vpg6w-1; Fri,
 24 Apr 2026 07:17:19 -0400
X-MC-Unique: WT64rUxYM6SJQqrt_vpg6w-1
X-Mimecast-MFC-AGG-ID: WT64rUxYM6SJQqrt_vpg6w_1777029438
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F13D91956059; Fri, 24 Apr 2026 11:17:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.30])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44C503007572; Fri, 24 Apr 2026 11:17:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C5F4321E6A28; Fri, 24 Apr 2026 13:17:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  "Dr. David Alan
 Gilbert" <dave@treblig.org>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 00/27] monitor: Remove need of per-target handlers
In-Reply-To: <fd5734e1-b4fd-4020-808e-90773d8d9403@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 24 Apr 2026 12:22:14
 +0200")
References: <20260414003001.97571-1-philmd@linaro.org>
 <87v7dgsn5x.fsf@pond.sub.org>
 <fd5734e1-b4fd-4020-808e-90773d8d9403@linaro.org>
Date: Fri, 24 Apr 2026 13:17:14 +0200
Message-ID: <877bpwsj45.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 24/4/26 11:49, Markus Armbruster wrote:
>> Doesn't apply to current master for me, and patchew couldn't apply it,
>> either.  Got something I could pull?
>
> My single-binary tree is having various dependencies on this series,
> do you mind if I merged it myself?

Do I mind if you take work off me?  Hell, no!  ;)

I asked because I'd like to give the series a quick eye-over, and I need
to compile locally for that.


