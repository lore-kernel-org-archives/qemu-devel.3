Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB30FC28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 07:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trtdo-00068M-AF; Tue, 11 Mar 2025 03:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trtdm-00067o-H4
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:03:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trtdk-0003LM-PK
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741676578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4xgyG3bW9gy7Zp0t13EpdAlKAQNdJAe7Qtcndxz1Vy0=;
 b=VZwxf8JY/4HXPgh+qO5FuUZQBvfGrDVvZU7BwOQADpIn9rN48tqdlspBB+vngilI7gzMWs
 UFkErUeRTutVr44QexIyONgRZYSsGRYfB5CR79mZVa1aW0oP5+rJXueuFPAW/tdykxQOnn
 kY6bv2MV332ro+IYSMLo3AOFf0y6+ic=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-g4hk8g1lNvuJ8I4gt0rl5Q-1; Tue,
 11 Mar 2025 03:02:54 -0400
X-MC-Unique: g4hk8g1lNvuJ8I4gt0rl5Q-1
X-Mimecast-MFC-AGG-ID: g4hk8g1lNvuJ8I4gt0rl5Q_1741676573
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D17419560A1; Tue, 11 Mar 2025 07:02:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7973818001F6; Tue, 11 Mar 2025 07:02:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C1A8D21E66C1; Tue, 11 Mar 2025 08:02:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 33/63] qapi: clean up encoding of section kinds
In-Reply-To: <20250311034303.75779-34-jsnow@redhat.com> (John Snow's message
 of "Mon, 10 Mar 2025 23:42:31 -0400")
References: <20250311034303.75779-1-jsnow@redhat.com>
 <20250311034303.75779-34-jsnow@redhat.com>
Date: Tue, 11 Mar 2025 08:02:48 +0100
Message-ID: <87frjk82xz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

John Snow <jsnow@redhat.com> writes:

> We have several kinds of sections, and to tell them apart, we use
> Section attribute @tag and also the section object's Python type:
>
>               type        @tag
>     untagged  Section     None
>     @foo:     ArgSection  'foo'
>     Returns:  Section     'Returns'
>     Errors:   Section     'Errors'
>     Since:    Section     'Since'
>     TODO:     Section     'TODO'
>
> Note:
>
> * @foo can be a member or a feature description, depending on context.
>
> * tag == 'Since' can be a Since: section or a member or feature
>   description.  If it's a Section, it's the former, and if it's an
>   ArgSection, it's the latter.
>
> Clean this up as follows.  Move the member or feature name to new
> ArgSection attribute @name, and replace @tag by enum @kind like this:
>
>               type         kind     name
>     untagged  Section      PLAIN
>     @foo:     ArgSection   MEMBER   'foo'   if member or argument
>               ArgSection   FEATURE  'foo'   if feature
>     Returns:  Section      RETURNS
>     Errors:   Section      ERRORS
>     Since:    Section      SINCE
>     TODO:     Section      TODO
>
> The qapi-schema tests are updated to account for the new section names;
> "TODO" becomes "Todo" and `None` becomes "Plain" there.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


