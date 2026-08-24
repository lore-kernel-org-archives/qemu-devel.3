Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC77CC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyOzI-0000ej-3j; Mon, 24 Aug 2026 03:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyOzF-0000b8-ND
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wyOzD-0000m0-55
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787556049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=KFLiUGru66zP5yLGusbHQzWL4m/cLTCvziQwuP+9vSM=;
 b=HDBow7qyr5B/5ocwVSwEaJGfyHsADkhpdBi64G1Tdze0rTpWVyNyidzkPAL+VmaI8KaEhU
 jKK/jlRDu/UPxpB4AVY3E262PFFtlTjgPjRbxVFEud36ke4+jEwFlbShvvb7KNGQIru4cg
 D26Abw2C3RZhoDeiLxcHEcmU6iMdeqE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-kzMKR4QXMomU-x0T6jQxKw-1; Mon,
 24 Aug 2026 03:20:47 -0400
X-MC-Unique: kzMKR4QXMomU-x0T6jQxKw-1
X-Mimecast-MFC-AGG-ID: kzMKR4QXMomU-x0T6jQxKw_1787556046
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F2AEF180A9FD; Mon, 24 Aug 2026 07:20:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 750F31800348; Mon, 24 Aug 2026 07:20:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DC21F21E6920; Mon, 24 Aug 2026 09:20:42 +0200 (CEST)
Resent-To: qemu-devel@nongnu.org, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, anjo@rev.ng
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 24 Aug 2026 09:20:42 +0200
Resent-Message-ID: <87wltgugqd.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 philmd@oss.qualcomm.com,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>, anjo@rev.ng
Subject: Re: [PATCH v2 1/2] qom/object: add available_if field to TypeInfo
In-Reply-To: <20260821235112.193381-2-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Fri, 21 Aug 2026 23:51:11 +0000")
References: <20260821235112.193381-1-pierrick.bouvier@oss.qualcomm.com>
 <20260821235112.193381-2-pierrick.bouvier@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 08:01:37 +0200
Message-ID: <87ld9wvyym.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> With the single-binary, we start mixing types for different targets,
> that may or may not be available for current one.
>
> Previously, we implemented an approach based on interfaces, but it
> proved to be too limited. It requires duplication between
> machines/cpus/devices, and does not handle specific cases where a type
> should be available based on a target configuration (Kconfig).
>
> To solve this, we add a new field, available_if, to TypeInfo.
> It is an array containing a list of requirements for type to be
> available.
>
> For now, we have only targets as requirements, but later we'll add
> specific target config entries also.
>
> We also add a TARGET_REQS macro, to declare a list of requirements. For
> sanity sake, we don't use a complex variadic macro prefixing each
> parameter. It requires a lot of macro boilerplate in C, and prevent
> readers to jump easily to definition for each parameter.
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  include/qemu/target-info.h | 11 +++++++++++
>  include/qom/object.h       |  5 +++++
>  qom/object.c               | 10 ++++++++++
>  rust/qom/src/qom.rs        |  1 +
>  stubs/meson.build          |  1 +
>  stubs/target-info.c        | 11 +++++++++++
>  target-info.c              | 13 +++++++++++++
>  7 files changed, 52 insertions(+)
>  create mode 100644 stubs/target-info.c
>
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index 6c5b714288e..6379e65bbcf 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -50,6 +50,17 @@ const char *target_cpu_type(void);
>   */
>  bool target_big_endian(void);
>  
> +typedef enum TargetReq {
> +    /* 0 is reserved for end of array */
> +    TARGET_REQ_BASE_ARM = 1,
> +    TARGET_REQ_AARCH64,
> +    TARGET_REQ_ARM,
> +} TargetReq;
> +
> +#define TARGET_REQS(...) (const TargetReq[]){__VA_ARGS__, 0}

The sentinel 0 is not a member of the enum.

Is this safe?  I'm asking because the C standard is infatuated with
undefined behavior.  Checking C99...  all I can find is Annex I "Common
warnings"

         -- A  value  is  given to an object of an enumeration type
            other than by assignment  of  an  enumeration  constant
            that  is  a  member  of  that  type,  or an enumeration
            variable that has the same type,  or  the  value  of  a
            function   that   returns  the  same  enumeration  type

Looks like it's safe.

[...]


