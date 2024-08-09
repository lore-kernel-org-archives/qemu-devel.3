Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47DDDC52D7C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 10:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scMah-00010u-4q; Fri, 09 Aug 2024 06:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1scMaf-00010M-H3
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 06:11:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1scMad-0005SJ-UB
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 06:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723198278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=863qgbxnWFPXgGGhrNH6kSjABxWoZekzrI/UHr9zjSo=;
 b=DsI8ENZcnbVDmKrQmGG9iWXiuGaH+uKsxemKhsoRMTKFZlpp5MhKlSLV6Z7fBLsYaEWGYw
 ID48w6G0hS9nH6HG13o6A8PJm1MK7kIUqs2lsAqrDfMLDAQVM7vjX+pBLyAmQXGasciVWF
 sMk9XYFZQIkyFTLy8xF3HN4sStqM1/Q=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-tpCzOzk5P4eiu-2oipoUbw-1; Fri,
 09 Aug 2024 06:11:14 -0400
X-MC-Unique: tpCzOzk5P4eiu-2oipoUbw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8F7E1944AAB; Fri,  9 Aug 2024 10:11:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.245])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11E3F19560A3; Fri,  9 Aug 2024 10:11:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AA38521E668B; Fri,  9 Aug 2024 12:11:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Markus Armbruster <armbru@redhat.com>,  <qemu-devel@nongnu.org>
Subject: Re: CxlCorErrorType member @retry-threshold is undocumented
In-Reply-To: <20240809110420.000061b0@Huawei.com> (Jonathan Cameron's message
 of "Fri, 9 Aug 2024 11:04:20 +0100")
References: <87mslmrjhd.fsf@pond.sub.org> <20240809110420.000061b0@Huawei.com>
Date: Fri, 09 Aug 2024 12:11:10 +0200
Message-ID: <87frrej9a9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Thu, 08 Aug 2024 19:51:26 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> Hi Jonathan,
>> 
>> You added the type in commit 415442a1b4a (hw/mem/cxl_type3: Add CXL RAS
>> Error Injection Support.)  The doc comment is missing a description of
>> @retry-threshold.  Can you supply me one?  I'm happy to do the actual
>> patch.
>> 
> Sorry!
>
> The CXL spec text is
>
> Retry Threshold Hit. (NUM_RETRY >= MAX_NUM_RETRY). Applicable only to 68B Flit Mode.
> +  a reference to the local retry state machine (LRSM)
>
> So maybe
>
> "Retry threshold hit in the Local Retry State Machine, 68B Flits only."

Is "Local Retry State Machine" a name or a description?  The former may
be capitalized, the latter not.


