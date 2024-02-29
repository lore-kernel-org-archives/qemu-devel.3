Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273F1C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 08:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcC5-0004GK-2F; Thu, 29 Feb 2024 03:55:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfcC4-0004Fu-1h
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:55:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfcBy-0000ul-ES
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 03:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709196901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=YjLQuBE8VjLTG15gnUduGLzgQ7fKqrsO+ViK7/wp2qU=;
 b=cU2Y+vn2Tu27TlC37wxUt8pxMQid2BYKmqW4oeaL44phg/NkbslFfd0amVpmQ6KmkpLPbJ
 wpiqe7J0b9IgfO4vecL0uW1d/tP68VHETxyv9K2bi6totpcdowqycKwOW5/Nje1rEUJ2wm
 VdP+CR4FDSV14FsgmEeTRo5lOgTpklA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-BH8tX2uONB-YXM_sbWV4-Q-1; Thu, 29 Feb 2024 03:54:57 -0500
X-MC-Unique: BH8tX2uONB-YXM_sbWV4-Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D63287B2A0;
 Thu, 29 Feb 2024 08:54:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 48497492BC6;
 Thu, 29 Feb 2024 08:54:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F4D321E6740; Thu, 29 Feb 2024 09:54:55 +0100 (CET)
Resent-To: michael.roth@amd.com, isaku.yamahata@gmail.com,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, wangyanan55@huawei.com,
 chenyi.qiang@intel.com, xiaoyao.li@intel.com, philmd@linaro.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, cfontana@suse.de,
 kvm@vger.kernel.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Thu, 29 Feb 2024 09:54:55 +0100
Resent-Message-ID: <87plwfzm3k.fsf@pond.sub.org>
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
Subject: Re: [PATCH v5 12/65] i386: Introduce tdx-guest object
In-Reply-To: <20240229063726.610065-13-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Thu, 29 Feb 2024 01:36:33 -0500")
References: <20240229063726.610065-1-xiaoyao.li@intel.com>
 <20240229063726.610065-13-xiaoyao.li@intel.com>
Date: Thu, 29 Feb 2024 09:19:55 +0100
Message-ID: <87msrj1y38.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> Introduce tdx-guest object which inherits CONFIDENTIAL_GUEST_SUPPORT,
> and will be used to create TDX VMs (TDs) by
>
>   qemu -machine ...,confidential-guest-support=tdx0	\
>        -object tdx-guest,id=tdx0
>
> So far, it has no QAPI member/properety decleared and only one internal
> member 'attributes' with fixed value 0 that not configurable.
>
> QAPI properties will be added later.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Markus Armbruster <armbru@redhat.com>

I'm happy with the commit message now.  Thanks!


