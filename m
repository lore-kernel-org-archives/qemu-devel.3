Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511C8C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 14:58:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2XsZ-0004iW-DZ; Thu, 02 May 2024 10:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1s2XsX-0004ey-Pt
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:57:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1s2XsP-0007ur-Sn
 for qemu-devel@nongnu.org; Thu, 02 May 2024 10:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714661853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oZVjeHVD/CL+nzKGkD+pCwIH+ZB9KHcsJ5PGMvWTld8=;
 b=Q8+GbJjyj436krTeeKh1GsV1fb7LYKs73PIa2SIbC9mT9bhaZWHVUViFOZpJpEBprfhRka
 U98h7NrFndh2oI8EdzxR3OOYZ/UTUZF5KqaJEBTrFOgE9ql/OXk53ciGc//mXPy3uz+9Kc
 w6fc+UogvEupR7N3Kyh6oC2bQjf5Ivk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-111-CgyvIKI-OViInfa36XgqXw-1; Thu,
 02 May 2024 10:57:30 -0400
X-MC-Unique: CgyvIKI-OViInfa36XgqXw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B69D93C02740;
 Thu,  2 May 2024 14:57:27 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 50AE71C060D0;
 Thu,  2 May 2024 14:57:23 +0000 (UTC)
Date: Thu, 2 May 2024 09:57:21 -0500
From: Eric Blake <eblake@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Nicholas Piggin <npiggin@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clegoate@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, 
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org, 
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Subject: Re: [PATCH 01/14] include/hw: add helpers for defining versioned
 machine types
Message-ID: <6lfkvaovs4tz5nep43zw5ueudqy2zrns6fttu4bmq3q5wqvgqx@hxnvw7sqsyzo>
References: <20240501182759.2934195-1-berrange@redhat.com>
 <20240501182759.2934195-2-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240501182759.2934195-2-berrange@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
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

On Wed, May 01, 2024 at 07:27:46PM +0100, Daniel P. Berrangé wrote:
> The various targets which define versioned machine types have
> a bunch of obfuscated macro code for defining unique function
> and variable names using string concatenation.
> 
> This addes a couple of helpers to improve the clarity of such
> code macro.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  include/hw/boards.h | 166 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 166 insertions(+)
> 
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 2fa800f11a..47ca450fca 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -414,6 +414,172 @@ struct MachineState {
>      struct NumaState *numa_state;
>  };
>  
> +/*
> + * The macros which follow are intended to facilitate the
> + * definition of versioned machine types, using a somewhat
> + * similar pattern across targets:
> + *
> + *  #define DEFINE_VIRT_MACHINE_IMPL(latest, ...) \
> + *      static void MACHINE_VER_SYM(class_init, virt, __VA_ARGS__)( \
> + *          ObjectClass *oc, \
> + *          void *data) \
> + *      { \
> + *          MachineClass *mc = MACHINE_CLASS(oc); \
> + *          MACHINE_VER_SYM(options, virt, __VA_ARGS__)(mc); \

Nice to include example usage of the macros.  __VA_ARGS__ is getting
expanded quite a few times here, but I don't see that as being too
much of a problem.

> + *  // Normal 2 digit eg 'virt-9.0'
> + *  #define DEFINE_VIRT_MACHINE(major, minor) \
> + *      DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
> + *
> + *  // Bugfix 3 digit  eg 'virt-9.0.1'

Inconsistent on whether you are using one or two spaces before 'eg'.

> +
> +#define _MACHINE_VER_PICK(x1, x2, x3, x4, x5, x6, ...) x6

This helper macro is powerful; it may be worth a short comment, maybe
along the lines of:

/* Helper macro used to pick the right macro name based on the number
 * of extra arguments passed to the containing macro; usage:
 *
 *  _MACHINE_VER_PICK(__VA_ARGS__, \
 *                    MACRO_FOR_5_ARGS, \
 *                    MACRO_FOR_4_ARGS, \
 *                    MACRO_FOR_3_ARGS, \
 *                    MACRO_FOR_2_ARGS)(optional prefix args, __VA_ARGS__)
 */

But once understood, I see it comes in handy in several places below.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


