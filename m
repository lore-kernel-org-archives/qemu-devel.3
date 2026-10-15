Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D73CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 11:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJW9-00021Y-EX; Thu, 15 Oct 2026 07:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHJW7-00020P-KL
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xHJW6-00041z-77
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 07:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792063257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LFLvtlp9ajXuyqozQZdY5XeXESiHPlutrjMv96ZlBqQ=;
 b=T2jtkJu1/ORJoH8jID5PcaiNrZnXbjcCYgCh/t3iXQqlsUhIOdFRNPWx6rQkEF2VS74uiD
 YXQD8iI9jECNrdcYjI0M6CSog+gjZQg5VUwzXHkaj2rcqUL/a/4T930dNg8ji1miXWTyUh
 kUEAfpQiIPobQJtMQC/wn93FzScm8nw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-IwqoP-otNzeGRy1MI6XwDg-1; Thu,
 15 Oct 2026 11:20:56 +0000
X-MC-Unique: IwqoP-otNzeGRy1MI6XwDg-1
X-Mimecast-MFC-AGG-ID: IwqoP-otNzeGRy1MI6XwDg_1792063255
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 321CC18002C0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:20:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E50C7180057F
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:20:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 817A421E6A04; Thu, 15 Oct 2026 13:20:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org,  Gerd Hoffmann <kraxel@redhat.com>,  Stefano
 Garzarella <sgarzare@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] igvm: add command line parameter support
In-Reply-To: <20261015-igvm_command_line-v2-1-1f358acfdf2f@redhat.com> (Luigi
 Leonardi's message of "Thu, 15 Oct 2026 12:41:57 +0200")
References: <20261015-igvm_command_line-v2-1-1f358acfdf2f@redhat.com>
Date: Thu, 15 Oct 2026 13:20:52 +0200
Message-ID: <87bj8v9pm3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Luigi Leonardi <leonardi@redhat.com> writes:

> Add a "cmdline" property to the igvm-cfg object and a handler for the
> IGVM_VHT_COMMAND_LINE directive, which copies the string into the
> parameter area the directive points at.
>
> The command line is passed to whatever software the IGVM file loads,
> such as an SVSM. For example, SVSM can use it to select the serial port
> it logs to.
>
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


