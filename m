Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC4DC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 07:20:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjZws-0002ZA-Ku; Mon, 11 Mar 2024 03:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjZwr-0002Yy-BR
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rjZwp-00011h-M5
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 03:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710141586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KzmgNmvdgICSA1NYTbStaHOdkDJR2rq7jAMYhzhcMos=;
 b=I+lC2JLK6xhYCbnZ+MB2CGqiSPXHDr24LWk0VUlQqKJcH78f2y16fOK8ovYkO8QZZDji5Y
 6Xn7Gu/IPDcsvSZKYIEx4P8ty6cXHliYONPQ8fUABGb8+VvSqvy/x/ne1V5nwP30HiYuts
 qHWRsIdvbWk+q9NZylMBey1dtytsqvg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-533-r3vqO6KEOmuA7R-NVAsR8g-1; Mon,
 11 Mar 2024 03:19:42 -0400
X-MC-Unique: r3vqO6KEOmuA7R-NVAsR8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B893628116A4;
 Mon, 11 Mar 2024 07:19:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 45E543C23;
 Mon, 11 Mar 2024 07:19:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A6EA21E6A24; Mon, 11 Mar 2024 08:19:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Richard
 Henderson <richard.henderson@linaro.org>,  Ani Sinha
 <anisinha@redhat.com>,  Peter Xu <peterx@redhat.com>,  Cornelia Huck
 <cohuck@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org,  qemu-devel@nongnu.org,  Michael Roth
 <michael.roth@amd.com>,  Claudio Fontana <cfontana@suse.de>,  Gerd
 Hoffmann <kraxel@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v5 30/65] i386/tdx: Support user configurable
 mrconfigid/mrowner/mrownerconfig
In-Reply-To: <5f426c46-1a8b-426d-bd7f-aeee95cc5219@intel.com> (Xiaoyao Li's
 message of "Mon, 11 Mar 2024 09:25:24 +0800")
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-31-xiaoyao.li@intel.com>
 <87edcv1x9j.fsf@pond.sub.org>
 <f9774e89-399c-42ad-8fa8-dd4050ee46da@intel.com>
 <871q8vxuzx.fsf@pond.sub.org>
 <4602df24-029e-4a40-bdec-1b0a6aa30a3c@intel.com>
 <87v85yv3j9.fsf@pond.sub.org>
 <0f3df4b7-ffb9-4fc5-90eb-8a1d6fea5786@intel.com>
 <87ttli87sw.fsf@pond.sub.org>
 <5f426c46-1a8b-426d-bd7f-aeee95cc5219@intel.com>
Date: Mon, 11 Mar 2024 08:19:40 +0100
Message-ID: <87v85tutf7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.945,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 3/7/2024 9:56 PM, Markus Armbruster wrote:

[...]

>> Alright, the doc comment is not the place to educate me about TDX.
>
> I'm pleased to help you (on or off the maillist) if you have any question on TDX. :)

I can't possibly become knowledgable about QEMU's entire external
interface, it's simply too much.  Where I'm ignorant, I try to learn
just enough to ensure the documentation is useful.

I appreciate your kind & patient help with that.

>> Perhaps we can go with
>> # @mrconfigid: ID for non-owner-defined configuration of the guest TD,
>> #     e.g., run-time or OS configuration (base64 encoded SHA384 digest).
>> #     Defaults to all zeroes.
>> 
>
> I will update to this in next version.
> Huge thanks for your help!

You're welcome!


