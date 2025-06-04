Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24601C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 06:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMhST-0000kE-S5; Wed, 04 Jun 2025 02:18:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMhSL-0000fR-Jx
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:18:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMhSI-0000PI-TE
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 02:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749017909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8k+xLolXlFGzg+BEq0rS5J+CA9iF3pdk0CJqLp0i2gY=;
 b=Z8ARQxK7IosePh7C69eAQ7SQ6D79xWbGRhJNQD07yo7y+lpC6wwqg9Hx4mbIl4gl0yBAKw
 ohaHSFpcs30LvH3zsf4W+OnhC6csMhV8HY8yg+TvzrSLd9VbMD6YifD+aFHbWwXzYng2yy
 SjrV3OMdiYp+EIvaNdG/a9cBWIgQubk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-g6115mSkPsWHkyAJs0YdxA-1; Wed,
 04 Jun 2025 02:18:27 -0400
X-MC-Unique: g6115mSkPsWHkyAJs0YdxA-1
X-Mimecast-MFC-AGG-ID: g6115mSkPsWHkyAJs0YdxA_1749017905
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD97318004A3; Wed,  4 Jun 2025 06:18:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 380EF19560AB; Wed,  4 Jun 2025 06:18:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A26921E6757; Wed, 04 Jun 2025 08:18:22 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Stefan
 Hajnoczi
 <stefanha@redhat.com>,  Alexander Graf <agraf@csgraf.de>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Stefan Hajnoczi
 <stefanha@gmail.com>
Subject: Re: [PATCH v3 3/3] docs: define policy forbidding use of AI code
 generators
In-Reply-To: <aD8WqcGz_zvqqj2Y@redhat.com> (Kevin Wolf's message of "Tue, 3
 Jun 2025 17:37:13 +0200")
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-4-armbru@redhat.com>
 <aD8WqcGz_zvqqj2Y@redhat.com>
Date: Wed, 04 Jun 2025 08:18:22 +0200
Message-ID: <875xhc113l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

Kevin Wolf <kwolf@redhat.com> writes:

> Am 03.06.2025 um 16:25 hat Markus Armbruster geschrieben:
>> +TL;DR:
>> +
>> +  **Current QEMU project policy is to DECLINE any contributions which are
>> +  believed to include or derive from AI generated code. This includes ChatGPT,
>> +  CoPilot, Llama and similar tools**
>
> [...]
>
>> +Examples of tools impacted by this policy includes both GitHub's CoPilot,
>> +OpenAI's ChatGPT, and Meta's Code Llama, amongst many others which are less
>> +well known.
>
> I wonder if the best list of examples is still the same now, a year
> after the original version of the document was written. In particular,
> maybe including an example of popular vibe coding IDEs like Cursor would
> make sense?
>
> But it's only examples anyway, so either way is fine.

Stefan suggested a few more, and I'll add them.

Thanks!


