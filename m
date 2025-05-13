Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1ECC3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 08:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEkYC-0003Tz-Qv; Tue, 13 May 2025 03:59:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEkYB-0003TI-3G
 for qemu-devel@nongnu.org; Tue, 13 May 2025 03:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uEkY9-0002XK-AM
 for qemu-devel@nongnu.org; Tue, 13 May 2025 03:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747123180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PadP7yY/ADcEds/RowrY7etafgZuAeKjgNp0EuiO5fw=;
 b=ibP+lDaR54lE9mlWAKWUtsDBC4i4SVhSlFI19SNnaDZsVD343fJs3T3GRxacx9kIGMfH5q
 X3Nen8OVUzRvemUm999D03MJKW9rn77sI6cniZVoKWYaVNS9X64Z9d3HcOGVNgjB8kKT7u
 7k5Yi6+6lrHAIc8Fzqu70Khqg2vqD0M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-3xy8beCqPLmoSNgsTZGBVw-1; Tue,
 13 May 2025 03:59:36 -0400
X-MC-Unique: 3xy8beCqPLmoSNgsTZGBVw-1
X-Mimecast-MFC-AGG-ID: 3xy8beCqPLmoSNgsTZGBVw_1747123175
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81D8F195D03A; Tue, 13 May 2025 07:59:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1E9D19560AB; Tue, 13 May 2025 07:59:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6ACA821E66C3; Tue, 13 May 2025 09:59:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from
 the schema
In-Reply-To: <26fb50ca-36fd-4aca-908c-272c5a109bac@linaro.org> (Pierrick
 Bouvier's message of "Mon, 12 May 2025 13:09:55 -0700")
References: <20250508135816.673087-1-berrange@redhat.com>
 <87y0v4zuec.fsf@pond.sub.org> <aCJAaawKsNFAtSmy@redhat.com>
 <26fb50ca-36fd-4aca-908c-272c5a109bac@linaro.org>
Date: Tue, 13 May 2025 09:59:32 +0200
Message-ID: <87v7q5gcuz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Pierrick Bouvier <pierrick.bouvier@linaro.org> writes:

> On 5/12/25 11:39 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Sat, May 10, 2025 at 11:28:59AM +0200, Markus Armbruster wrote:
>>> PATCH 10 empties out and deletes qapi/machine-target.json.  PATCH 04
>>> empties out qapi/misc-target.json without deleting it.  Missing:
>>>
>>> * Delete qapi/misc-target.json
>>>
>>> * Delete entry F: qapi/machine-target.json in MAINTAINERS
>>>
>>> * Delete dead logic around qapi_specific_outputs in qapi/meson.build
>>>
>>> The latter deserves its own PATCH 11.  Whether to delete the
>>> qapi/*-target.json in the patch that empties the file or in PATCH 11 is
>>> a matter of taste.
>>=20
>> FYI, after discussing with Pierrick, I'm going to let him take over
>> work on this patch series to drive it forward to something viable
>> to submit as a non-RFC.

No worries, you're passing them into capable hands.

> Thanks for your work Daniel, I'll continue the effort based on your=20
> approach.
>
> Just for information, I'll apply a Signed-off-by with my name to all=20
> patches posted (including the ones I won't touch) simply because I use
> git rebase --signoff by default, and don't want to have to do this=20
> manually and selectively, as I work with a single master, with stacked=20
> branches and update-refs.

We actually expect you to add your S-o-B to patches that go through your
tree whether you changed them or not.


