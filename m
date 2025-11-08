Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39D74CCFA18
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 09:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHfM6-00085P-7x; Sat, 08 Nov 2025 04:35:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHfLt-00080f-2j
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 04:35:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vHfLp-000458-3N
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 04:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762594514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yN0YWcIGW81FOzx98FEXhDhtiOpVnwKI02S6x38GJKk=;
 b=GvX3tXN+OvUScN5uPPTgE/3Qk7qNS20RRwlqQn/TCyICycqA/GH/EBfNUslHs48GhUCEXf
 IhrYqnud9L9W73p1nYZ6nY4f6TcHIfybwbg+M2a6NAVU5L2vUhpS6GInbo4U6jN5bhYSPt
 GTAo2TEbnw1RPdnezTQDRPmmhjd0fB8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-HofitqD4OdO8mG7PSaS0iA-1; Sat,
 08 Nov 2025 04:35:09 -0500
X-MC-Unique: HofitqD4OdO8mG7PSaS0iA-1
X-Mimecast-MFC-AGG-ID: HofitqD4OdO8mG7PSaS0iA_1762594508
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F22291956096; Sat,  8 Nov 2025 09:35:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3086230044E0; Sat,  8 Nov 2025 09:35:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 802A521E6A27; Sat, 08 Nov 2025 10:35:04 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 stefanb@linux.vnet.ibm.com,  qemu-devel@nongnu.org,  peterx@redhat.com
Subject: Re: [PATCH 2/3] tpm_emulator: drop direct use of errno variable
In-Reply-To: <bd855481-a93a-4406-bd0d-a02896b93296@linux.ibm.com> (Stefan
 Berger's message of "Fri, 7 Nov 2025 14:31:48 -0500")
References: <20251106194126.569037-1-vsementsov@yandex-team.ru>
 <20251106194126.569037-3-vsementsov@yandex-team.ru>
 <bd855481-a93a-4406-bd0d-a02896b93296@linux.ibm.com>
Date: Sat, 08 Nov 2025 10:35:04 +0100
Message-ID: <87tsz46f5j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stefan Berger <stefanb@linux.ibm.com> writes:

> On 11/6/25 2:41 PM, Vladimir Sementsov-Ogievskiy wrote:
>> The code tends to include errno into error messages after
>> tpm_util_test_tpmdev() and tpm_emulator_ctrlcmd() calls.
>> Both has error paths, where errno is not set, examples:
>
> Both have ...>
>> tpm_emulator_ctrlcmd()
>>    qemu_chr_fe_write_all()
>>      qemu_chr_write()
>>        replay_char_write_event_load()
>>          ...
>>          *res = replay_get_dword();
>>          ...
>> tpm_util_test_tpmdev()
>>    tpm_util_test()
>>      tpm_util_request()
>>        ...
>>        if (n != requestlen) {
>>            return -EFAULT;
>>        }
>>        ...
>> Both doesn't document that they set errno.
>
> Both do not ...
>
>> Let's drop these explicit usage of errno. If we need this information,
>> it should be added to errp deeper in the stack.
>
> It's not clear to me why this is an actual problem. Is it better to now not set this error message?

Error messages lacking information are bad.  Error messages with
incorrect information are *worse*.  When the error message lacks
information I need, I usually realize it immediately.  When it lies to
me, I don't.

Before this patch, correct information is mixed up with incorrect
information.  At the point where we format it into error messages, we
have no idea whether it's correct.  Thus, the error messages lie at
least some of the time.  That's a bug.

The patch fixes that bug at the cost of losing some correct information
along with the lies.

If you'd rather lose just the lies, that's possible, but more involved.
As the saying goes: patches welcome!

[...]


