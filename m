Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98143C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 07:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl2Lh-0002z8-Pc; Fri, 15 Mar 2024 03:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl2Le-0002yw-2h
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl2Lb-000181-1d
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 03:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710489080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WhFDkel+O8KY+AsVre4U06BIjbQ5a2sYQ0ZvV7mJHuQ=;
 b=jKkf3fT7F6hV9VUhcOnGf2e2k6d/LjuX8zb3vgwUbF7WVlQvuZvYnUV3Cq1s7xoZqHIIGJ
 ohAVImetwVlAE3rd7oNOdoGKsEfk6wC11AlWLWxx7l8KguSjWRr7hH0TAgb2oD/4MwCoNg
 OelVDyiFe1O7JfD34yH5kDY0zSd2JRo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-253-Wo_Mun3qPiKM426vymiLlw-1; Fri,
 15 Mar 2024 03:51:18 -0400
X-MC-Unique: Wo_Mun3qPiKM426vymiLlw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D3BA1380673E;
 Fri, 15 Mar 2024 07:51:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E017202451F;
 Fri, 15 Mar 2024 07:51:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8EC8B21E6A24; Fri, 15 Mar 2024 08:51:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>,  qemu-devel@nongnu.org,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v4 0/3] Adjust the output of x-query-virtio-status
In-Reply-To: <20240313070857-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Wed, 13 Mar 2024 07:11:16 -0400")
References: <cover.1708525606.git.yong.huang@smartx.com>
 <20240312121944-mutt-send-email-mst@kernel.org>
 <87h6hah7bb.fsf@pond.sub.org>
 <20240313051034-mutt-send-email-mst@kernel.org>
 <87msr2fp16.fsf@pond.sub.org>
 <20240313070857-mutt-send-email-mst@kernel.org>
Date: Fri, 15 Mar 2024 08:51:16 +0100
Message-ID: <871q8cj5l7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Mar 13, 2024 at 10:40:21AM +0100, Markus Armbruster wrote:
>> I could be awkward for the use case described in PATCH 1's commit
>> message:
>> 
>>     However, we sometimes want to compare features and status bits without
>>     caring for their exact meaning.  Say we want to verify the correctness
>>     of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can use
>>     QMP command x-query-virtio-status to retrieve vhost-user net device
>>     features, and the "ovs-vsctl list interface" command to retrieve
>>     interface features.  Without commit f3034ad71fc, we could then simply
>>     compare the numbers.  With this commit, we first have to map from the
>>     strings back to the numeric encoding.
>
> So, consider how guest kernel presents features then. Do you happen to know?
> It's actually a binary string:
>
> static ssize_t features_show(struct device *_d,
>                              struct device_attribute *attr, char *buf)
> {
>         struct virtio_device *dev = dev_to_virtio(_d);
>         unsigned int i;
>         ssize_t len = 0;
>
>         /* We actually represent this as a bitstring, as it could be
>          * arbitrary length in future. */
>         for (i = 0; i < sizeof(dev->features)*8; i++)
>                 len += sysfs_emit_at(buf, len, "%c",
>                                __virtio_test_bit(dev, i) ? '1' : '0');
>         len += sysfs_emit_at(buf, len, "\n");
>         return len;
> }
> static DEVICE_ATTR_RO(features);

I'm willing to accept any reasonably compact representation of the bits
that is easy to use for the comparison use case.

I strongly prefer integers as long as their width suffices.

Since out integers are limited to 64 bits, and you want us to design for
more, we need something else.

I'm fine with array of integers, but you don't like it.

We generally avoid encoding stuff in strings, but using strings for
"overwide" integers isn't as bad as using them for structured data.  I
guess I'd be okay with it.

I'd use decimal simply to keep these "overwide" integers as close as
possible to regular ones.

If using base 2 enables string compare for the comparison use case,
that's an argument for base 2.

Hyman Huang, can you show us example output of "ovs-vsctl list
interface"?


