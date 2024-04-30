Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6622C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 05:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1g15-0004A8-5W; Tue, 30 Apr 2024 01:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1g12-00049W-RI
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:26:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s1g0y-00084Y-52
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 01:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714454810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ijDlNVLToT3HRYiGff0G7UxysWf3wd/3dFkRSr/pZuU=;
 b=e0MzCZUpxFN2cjYi+FUZ6Xgqw8eqzTbXdWaE04sG58Qjjlk7Du4E2rniKeZcxT5gk9FjOu
 W9I2GS6TsFdsZG+qs9WPBeog348BTH3lDOzslHldRaiA5gmhZ9+mAh4kNW7JnyCJSnBVZ+
 w/ce1wmVLctOLtcuas7Zif0JxPrlgpU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-cXLea1O1PRmC8Lh-2xqhPw-1; Tue, 30 Apr 2024 01:26:47 -0400
X-MC-Unique: cXLea1O1PRmC8Lh-2xqhPw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 493F11005D5C;
 Tue, 30 Apr 2024 05:26:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DC98C581C8;
 Tue, 30 Apr 2024 05:26:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 074C521E66E5; Tue, 30 Apr 2024 07:26:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Collin Walling <walling@linux.ibm.com>
Cc: qemu-s390x@nongnu.org,  qemu-devel@nongnu.org,  thuth@redhat.com,
 david@redhat.com,  wangyanan55@huawei.com,  philmd@linaro.org,
 marcel.apfelbaum@gmail.com,  eduardo@habkost.net
Subject: Re: [PATCH v4 1/2] target/s390x: report deprecated-props in
 cpu-model-expansion reply
In-Reply-To: <20240429191059.11806-2-walling@linux.ibm.com> (Collin Walling's
 message of "Mon, 29 Apr 2024 15:10:58 -0400")
References: <20240429191059.11806-1-walling@linux.ibm.com>
 <20240429191059.11806-2-walling@linux.ibm.com>
Date: Tue, 30 Apr 2024 07:26:46 +0200
Message-ID: <87zftbe7zd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Collin Walling <walling@linux.ibm.com> writes:

> Retain a list of deprecated features disjoint from any particular
> CPU model. A query-cpu-model-expansion reply will now provide a list of
> properties (i.e. features) that are flagged as deprecated. Example:
>
>     {
>       "return": {
>         "model": {
>           "name": "z14.2-base",
>           "deprecated-props": [
>             "bpb",
>             "csske"
>           ],
>           "props": {
>             "pfmfi": false,
>             "exrl": true,
>             ...a lot more props...
>             "skey": false,
>             "vxpdeh2": false
>           }
>         }
>       }
>     }
>
> It is recommended that s390 guests operate with these features
> explicitly disabled to ensure compatability with future hardware.
>
> Signed-off-by: Collin Walling <walling@linux.ibm.com>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


