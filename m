Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D69C55184
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 11:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrDbI-0004f4-CX; Tue, 04 Aug 2026 07:46:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrDbH-0004ew-G9
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1wrDbG-0005Kp-1s
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 07:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785843984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RydKQD+AWojSUXW7szxPRLcbNtBFBTnZRdNs4Z+UpSU=;
 b=gjdsoslMqPlr3k7sV6FfUWOTIL8fCY/kLNq4D/o3zh7bg/fHZJYKTFxbAPS/JSEK7PpkKN
 I6xVbkfCAbyMF45J1v9rBZ+K9SnR8TApCb54Lcl4UkTGOy4AgvccmkJ+lhAMOYdSPLY8c7
 7Fgs2NS/2WE1ivglU2emxayAs5pfSdE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-DKF3vXqpMh-BkcyIxqVtQQ-1; Tue, 04 Aug 2026 07:46:13 -0400
X-MC-Unique: DKF3vXqpMh-BkcyIxqVtQQ-1
X-Mimecast-MFC-AGG-ID: DKF3vXqpMh-BkcyIxqVtQQ_1785843972
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4956c1655c3so19038745e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 04:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785843972; x=1786448772; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RydKQD+AWojSUXW7szxPRLcbNtBFBTnZRdNs4Z+UpSU=;
 b=FxKjyFqAu46t+usHnXpniZsgDDCdwX6N+Xu1ZGZRK2+wNKtPyVyBTMt4jrdbTgQVdN
 bnDY/Jtifl/hKIMVin3a4bkMQYPwRhXjfOk072S7UM8Q7WASsFcVHHAZTVS3XLyWpXbF
 YedbF23WjPo7vVjA3/sG0FyJqvv5pnoC0zGf6R7kFNmpl6rlGu4gt7b/AKbGiHhC3rvD
 SrUnruhHB2x9VSuQ2PO1EKNAvMySyKhEBU1pYdWPd0Ks4ORzcQOipuyo+tocMh3Pz5Nw
 QHQ7qtU1aLRhPknzXRr5WY1YeOK+vknvKzvdCV4kxn284fSpK4DPAr8X/bp6EQlaxnkz
 8YvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785843972; x=1786448772;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RydKQD+AWojSUXW7szxPRLcbNtBFBTnZRdNs4Z+UpSU=;
 b=RQYsX0SqDQ0XOH930sbihlh5p/fK/LMswJo+/YOC9ukNne1Phrir5EieChDDoYEHjS
 QDeMaRaPTKgisFk3MytZLgHstOrv7PVEGJsEf1ZKwg1/D4DO9FQpErjAWxP+2CNCgtR5
 Vc9spqWVMzCC+2O9Yhd6sB1xmjah/oZUPosRulw61/UT9WvURzePQjifJZmYaf52Prlz
 51j7eLYmoyx2HBX4UPfZ8SWq4TNxhPipaEm/bm8mUH2dXqzJ7VLFuKC9wkrakIUz389d
 Yqbdqs7u7au+o/awwmaAfoHg4fZi7GegFi0XaqyfQHY8Yic4gcvkyK8fS2hExHxLkNJE
 PiRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHcu1IwBYgXkxQigvi5lrwj9R2sf3OrGjiec12Plu40Em+aT7IzwKIlHCLAU6JGsDEYJlor5ZcsSRp@nongnu.org
X-Gm-Message-State: AOJu0YyD+aALONO3rf1nqDYJXED5SGXQMftfYhXfTgauT8+b728xec51
 3aKn6z5UByEu6AR0ElzweKbfLmEgcftjuHksupJe3Z44UhTJ48dbJR1dc1JlPWt40Jq2DWLY6XB
 4rMAXo1BJ8WA7leqH5B/UjMPeZrQVqO1TUZoswxRfPLD9LeppGpO2PgGZ
X-Gm-Gg: AR+sD10hvnl2L8u32O9sveSbLqLG3NRMUmB2r5WKNa8iDCdfcJArRzR45Hupj6zGPYl
 tiNYDg2TPbdln1sWuhpQjzfoYtD6+GICeVmsQ8jEtTDicDauBNPP2uKh6B/3KyXRcAPeMiUZY1P
 kqFuwKK0wdmfLiWIrw7g6RJ/zbeJssYlXnD3iESIfP0+2eTtmuzinJX32kiiONWBPdaaxaIlADk
 1XKo97AOxQbJqdT8lBdR7A3DjiCiP164ZgLCvNQcf3NjRCthLJQmDJ8NQPAVE47WLJnhuZ/ACpG
 YXcKOgdV1twTgdTE1Mrl0/d5sSIRWNy7SuLq0c/OBjgNSQ17y1STdjpHzYwyaUE4MA9JhumTnJg
 R3Ra7hHzm7lKCx2NaKZ5ueh0tMsg3CKwg8WZPF1aO/9NBoORBadRGcenoUmBD/0HnHOCdgAmeQe
 7Gixoee0l4Aq/bLJS6qEZ3XnE07yQqtQ==
X-Received: by 2002:a05:600c:840f:b0:496:c361:fb96 with SMTP id
 5b1f17b1804b1-4980c600ce6mr280556305e9.0.1785843971661; 
 Tue, 04 Aug 2026 04:46:11 -0700 (PDT)
X-Received: by 2002:a05:600c:840f:b0:496:c361:fb96 with SMTP id
 5b1f17b1804b1-4980c600ce6mr280555705e9.0.1785843971194; 
 Tue, 04 Aug 2026 04:46:11 -0700 (PDT)
Received: from ?IPV6:2003:cf:d73d:54bb:1189:33b6:6950:ef97?
 (p200300cfd73d54bb118933b66950ef97.dip0.t-ipconnect.de.
 [2003:cf:d73d:54bb:1189:33b6:6950:ef97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b84fb2sm200552435e9.1.2026.08.04.04.46.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 04:46:10 -0700 (PDT)
Message-ID: <9be3c3bb-8c41-4f9b-b396-0010cce0d75e@redhat.com>
Date: Tue, 4 Aug 2026 13:46:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] iotests/108: skip test if cannot access /dev/fuse
To: Eric Farman <farman@linux.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260728192644.2879028-1-farman@linux.ibm.com>
 <20260728192644.2879028-2-farman@linux.ibm.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260728192644.2879028-2-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 28.07.26 21:26, Eric Farman wrote:
> This test might fail if the user is not root (or sudo'd):
>
>    fusermount3: failed to open .../scratch/qcow2-file-108/fuse-export: Permission denied
>
> A check exists to try to cover for this, but there are
> two potential error messages that signal this case
> (per the comment block associated with the check) and
> only a skip for one of them.
>
> Update the common fuse check to include this message,
> and update test 108 to utilize it.
>
> Fixes: 9ffd6d646d ("iotests/108: Test new refcount rebuild algorithm")
> Based-on: <20260715103451.1930909-1-den@openvz.org>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>   tests/qemu-iotests/108       | 5 +----
>   tests/qemu-iotests/common.rc | 1 +
>   2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/tests/qemu-iotests/108 b/tests/qemu-iotests/108
> index bf808b3512..5d91e58943 100755
> --- a/tests/qemu-iotests/108
> +++ b/tests/qemu-iotests/108
> @@ -69,10 +69,7 @@ else
>       # or "Invalid parameter 'fuse'", depending on whether there is
>       # FUSE support or not.
>       error=$($QSD --export fuse 2>&1)
> -    if [[ $error = *"'fuse'"* ]]; then
> -        _notrun 'Passwordless sudo for losetup or FUSE support required, but' \
> -                'neither is available'
> -    fi
> +    _notrun_on_fuse_error "$error"
>   fi
>   
>   echo
> diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
> index bcb1ec50a9..844c19d15a 100644
> --- a/tests/qemu-iotests/common.rc
> +++ b/tests/qemu-iotests/common.rc
> @@ -986,6 +986,7 @@ _require_drivers()
>   _notrun_on_fuse_error()
>   {
>       case "$1" in
> +        *"Parameter 'id' is missing"* | \
>           *"Parameter 'type' does not accept value 'fuse'"*)
>               _notrun "No FUSE support"
>               ;;

Is “Parameter 'id' is missing” not the expected error message when there 
*is* FUSE support? At least for the case above in test 108.

Hanna


