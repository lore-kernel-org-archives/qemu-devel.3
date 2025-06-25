Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8B4C7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 09:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUM3O-00057e-SD; Wed, 25 Jun 2025 05:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uUM3K-00054a-4M
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uUM3G-0008Tf-J2
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750842255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U50q7bCcdWzc1ZcXjiGUxvRgnNgNJTxZORn6dJ7xdII=;
 b=ROnHGqU3VoTeQXPH5RI+o0vdVrYVZLQMiHe9Yl6kJ7gl8y0N0WIB5Xdtz5RRPoAqP/Q2YQ
 d4KwVSPoOpMCjiGYY/O7LfSZ+hMRrsAdO+0ph2iMuWr72Cv3kb89YutWx0qZ4aa9sALgAk
 +AwZUB5KXVEgYjrgEFtnYlm/bCEy544=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-kOw8bRI0NvaPfDnoNykUfg-1; Wed,
 25 Jun 2025 05:04:10 -0400
X-MC-Unique: kOw8bRI0NvaPfDnoNykUfg-1
X-Mimecast-MFC-AGG-ID: kOw8bRI0NvaPfDnoNykUfg_1750842249
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC75E1956057; Wed, 25 Jun 2025 09:04:08 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.230])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E066219560B3; Wed, 25 Jun 2025 09:04:03 +0000 (UTC)
Date: Wed, 25 Jun 2025 11:03:59 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH] s390x: Fix leak in machine_set_loadparm
Message-ID: <aFu7fz-PPw-bcVKB@redhat.com>
References: <20250509174938.25935-1-farosas@suse.de>
 <7a850346-8ae5-4dd2-b4ce-7ffb1cfeabd1@linaro.org>
 <1cd816d0-5808-4caf-b38b-9e4ba10680b6@linaro.org>
 <87sel9et69.fsf@suse.de>
 <e4e7a238-6438-481d-ae6c-8263730bc239@redhat.com>
 <87ikklqpwd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikklqpwd.fsf@suse.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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

Am 24.06.2025 um 14:34 hat Fabiano Rosas geschrieben:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 12/05/2025 17.37, Fabiano Rosas wrote:
> >> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> >> 
> >>> On 12/5/25 16:07, Philippe Mathieu-Daudé wrote:
> >>>> On 9/5/25 19:49, Fabiano Rosas wrote:
> >>>>> ASAN spotted a leaking string in machine_set_loadparm():
> >>>
> >>> What about ccw_device_set_loadparm() in hw/s390x/ccw-device.c?
> >>>
> >> 
> >> Yep, that one as well. I'll send a patch. Thanks
> >
> > Did you ever send it?
> 
> Sorry, no. Got sidetracked as usual. I'll mark this email so I don't forget.

I think Thomas asked because I posted the fix in our downstream bug
tracker. I just sent it as a proper patch.

Kevin


