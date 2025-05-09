Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB73C3ABBC
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 07:19:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDI16-0000u8-TS; Fri, 09 May 2025 03:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uDI15-0000ty-CM
 for qemu-devel@nongnu.org; Fri, 09 May 2025 03:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uDI13-0003V6-Ho
 for qemu-devel@nongnu.org; Fri, 09 May 2025 03:19:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746775166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f+eVov18gpL6NHiVTKX4S7QSo9I/Gk1DTt3koU5gwxw=;
 b=JfhIjcgB1CHYbipHWZwEEbmTnNVe0lE8IMf5WEqfa8VWnIKbi3FI1WX6QMPcABER7law0I
 5VG2bo7A2ywwq8EEYmQb8fg9BujOygN99EYvktK/yfMbsmsMezR0xy9jed0Zf2lauWp8TK
 wfAToE9iqX8d9Gpl7saAWpqBe6/rGJk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-JyzQTfHUOJehR49h8XFGLA-1; Fri,
 09 May 2025 03:19:24 -0400
X-MC-Unique: JyzQTfHUOJehR49h8XFGLA-1
X-Mimecast-MFC-AGG-ID: JyzQTfHUOJehR49h8XFGLA_1746775163
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F05F195608E; Fri,  9 May 2025 07:19:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A11D119560BC; Fri,  9 May 2025 07:19:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C78CC21E66C2; Fri, 09 May 2025 09:19:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: Nir Soffer <nirsof@gmail.com>,  qemu-devel@nongnu.org,
 qemu-block@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/2] block/null: Add read-pattern option
In-Reply-To: <mykoj5oasoeq3k4xa7c2f4kt4sybz3o7plf7wc6ma27auh7gst@2anh6h54xam7>
 (Eric Blake's message of "Thu, 8 May 2025 09:30:43 -0500")
References: <20250430203717.16359-1-nirsof@gmail.com>
 <20250430203717.16359-3-nirsof@gmail.com>
 <87h61vekn9.fsf@pond.sub.org>
 <mykoj5oasoeq3k4xa7c2f4kt4sybz3o7plf7wc6ma27auh7gst@2anh6h54xam7>
Date: Fri, 09 May 2025 09:19:19 +0200
Message-ID: <875xiab6a0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

Eric Blake <eblake@redhat.com> writes:

> On Thu, May 08, 2025 at 07:28:26AM +0200, Markus Armbruster wrote:
>> Let's take a step back from the concrete interface and ponder what we're
>> trying to do.  We want three cases:
>>=20
>> * Allocated, reads return unspecified crap (security hazard)
>>=20
>> * Allocated, reads return specified data
>>=20
>> * Sparse, reads return zeroes
>>=20
>> How would we do this if we started on a green field?
>>=20
>> Here's my try:
>>=20
>>     bool sparse
>>     uint8 contents
>>=20
>> so that
>>=20
>> * Allocated, reads return unspecified crap (security hazard)
>>=20
>>   @sparse is false, and @contents is absent
>>=20
>> * Allocated, reads return specified data
>>=20
>>   @sparse is false, and @contents is present
>>=20
>> * Sparse, reads return zeroes
>>=20
>>   @sparse is true, and @contents must absent or zero
>
> That indeed is a nice view of what we hope to test with.
>
>>=20
>> I'd make @sparse either mandatory or default to true, so that we don't
>> default to security hazard.
>>=20
>> Now compare this to your patch: same configuration data (bool =C3=97 uin=
t8),
>> better names, cleaner semantics, better defaults.
>>=20
>> Unless we want to break compatibility, we're stuck with the name
>> @read-zeroes for the bool, and its trap-for-the-unwary default value,
>> but cleaner semantics seem possible.
>>=20
>> Thoughts?
>
> What if we add @sparse as an optional bool, but mutually exclusive
> with @read-zeroes.  That would lead to 27 combinations of absent,
> present with 0 value, or present with non-zero value; but with fewer
> actual cases supported.  Something like your above table of what to do
> with sparse and contents, and with these additional rules:
>
> read-zeroes omitted, sparse omitted
>  - at present, defaults to sparse=3Dfalse for back-compat
>  - may change in the future [*]
> read-zeroes present, sparse omitted
>  - behaves like explicit setting of sparse, but with old spelling
>  - may issue a deprecation warning [*]
> read-zeroes omitted, sparse present
>  - explicit spelling, no warning (use above logic for how contents acts)
> read-zeroes and sparse both present
>  - error, whether values were same or different
>
> [*] Simultaneously, we start the deprecation cycle on @read-zeroes -
> tagging it as deprecated now, and removing it in a couple of releases.
> Once it is gone, we are left with just @sparse; at that time, we can
> decide to either make it mandatory (if so, we should warn now if
> neither read-zeroes nor sparse is specified), or leave it optional but
> change it to default true (so that the security hazard of sparse:false
> and omitted contents is now opt-in instead of default).

The recommended way to stay on top of deprecations in QMP is to test
with -compat deprecated-input=3Dreject,deprecated-output=3Dhide or similar.
This relies on special feature 'deprecated', and is limited to syntax.

There is no way to formally deprecate defaults.

We can deprecate @read-zeroes, but this wouldn't cover behavior when
absent.  Changing that is a compatibility break.  Hard to justify.

Except when the interface in question is unstable.  Block drivers
null-aio and null-co aren't.  Should they?

Warnings are awkward with QMP.  We can only warn to stderr.


