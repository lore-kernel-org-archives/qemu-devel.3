Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9767FCD8C85
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 15:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJZPK-0005dM-0F; Thu, 13 Nov 2025 10:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vJZPH-0005YN-5z
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vJZPE-0005Pw-RL
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 10:38:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763048318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+CwB15Zm/3FjNs1ajTTM4NVZyB97NFP2VomROl/dFQ=;
 b=GixhsAGjNzJJlohtKsEZ8jUPdtZdmmp0QxjsnFK85tW9j56D3YcmmC/jPCdVsPLLS3JilU
 gsFNVaFB0EVuZBfgbUlYVg5WYThFrK4BNYMj7QwLHT1qW0RIpcHDwtDYeu/uxZeqXVTSA/
 7VVObrN3mhvi5rHA+N+OdHGjUjEUv60=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-DB-9FrCVMGeEJjmVn8BBMQ-1; Thu, 13 Nov 2025 10:38:36 -0500
X-MC-Unique: DB-9FrCVMGeEJjmVn8BBMQ-1
X-Mimecast-MFC-AGG-ID: DB-9FrCVMGeEJjmVn8BBMQ_1763048315
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-64161017e34so974873a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763048315; x=1763653115; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S+CwB15Zm/3FjNs1ajTTM4NVZyB97NFP2VomROl/dFQ=;
 b=UqcERLM13OesuScS8V6MRgbyFJrFf5Yu+NNuOwO0E3qUOTsz050O5YyfqBpMo8RKcM
 sgk0zkW1kFkXHmlm2tzsDIBXpQ70Zv620UJMRh0UZmgtl6gelxhtyRI4291icCmdp0PX
 bqZICZX4s4xcVZY3FYOkZNrWnUOrDUazkxYkq9/wLgXcLhdGSq7uTBTfFrcJjo6R9g8X
 vaoWGYtI7JXetmUX+j6sCpmPQlzWHcYfIf39KzyjtJ17MhOpp+DX0ZivUc098HhGc7YF
 GbJc2inAO49uE775AoZXgUacSBqWuAsPPjhl9a8gaKjQbKpCSSczoC7QF8STV6XrNpkD
 hgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763048315; x=1763653115;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S+CwB15Zm/3FjNs1ajTTM4NVZyB97NFP2VomROl/dFQ=;
 b=QETlIPLJE7cWiEyenG8LJM4zenm92KwwqnDamxYV1gevwALMx2st8ZIShYU0E4QPzc
 wNs1kNY30E5Q96rRvptHj48QexlAYBhi/rLN5zF+1dcfy4fBi1V8E+wptfswpXGkPi1U
 kEIaOI8eqoKe5IAJ68D3pL2yqqZmrRJyq3jAfOmX+s45d1vysM2z+IVVkhN4yeWYKwm+
 AsX8mfCa2SNpz+eUT8RKIdYtMxttJs5OjYHWstPn4ryRXxxmDiPfcd5LobJ68aljFKEJ
 Lg+DSi45FAdNCxqXq/sXF1BIAL7N7iCUuGcGx7TuDUPwvEXA7xx4rN0YsdcN5CihJxTE
 yxOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpwBLcEjAN8B1gFnYtd3cfmkhw9FAXwfVjg+vgQy0BSWGyt4qF2vC3fS2RvLrtCypsGD20acttiLIS@nongnu.org
X-Gm-Message-State: AOJu0Yx2FBETJ4eJ7/yQRID0gCO2MlxvIuovhCAKDBvfGS9FVQmnBMMR
 auWpWHGNCxuiCgmBSd3U0N/l/1Te7FwEZvzeYHv/o7QTTTMp2247zBfqXruQUJCqjlTC4LaSCfr
 a0xPrNDm4uPcgxU0bCfB4eWq9pttXRqjb70ZjKXhf4Xns5XYbkzIrVSpH
X-Gm-Gg: ASbGncvd7m3QbRA17X6DfpH+Qw3HAz0srnHNJA30vSOTHYEI8LL2kOBIAhcLdjo67I3
 HtRjJYW7jdV30BAOS4kVl1lgH8aCmQW+TfwDyzIIemzBUk79xYcznO1lTRQYms/jwpX5jzVnS30
 C6V23Peh4iiFH6W+HxYTyGaWpR36Hm+3hURgLAW0G4ISdSxBCCLxLkySbnf8vL2NL/9nfyZ/xJ6
 SUR+RuXWyccykoHAdqXyAEt2dE9YTZXurNjqY5LzcBGDsUqbWeCkhHR/4quHFPAkQjG5TEJDibR
 RWAfkQPYeArSXQaVzpZF6eRrMzvZWYya53M0rWcgseKGa78pe1shn4pB439eKS8q6XsfJGNTg9D
 G8aVsIykIbYYnbibAf0MpriAYKeg2XMIeB5EcDLl4BNIFU8EJaEo=
X-Received: by 2002:a05:6402:354e:b0:634:5381:530b with SMTP id
 4fb4d7f45d1cf-6431a4b3a56mr6703578a12.13.1763048315246; 
 Thu, 13 Nov 2025 07:38:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH312LdxlN2+6L3xFCGQ6cF9N6vhEYkTMgjcMoBU++3kzQETZDv+QAzqLP5laLCKGkAxjT+EQ==
X-Received: by 2002:a05:6402:354e:b0:634:5381:530b with SMTP id
 4fb4d7f45d1cf-6431a4b3a56mr6703558a12.13.1763048314773; 
 Thu, 13 Nov 2025 07:38:34 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6433a3d839esm1664988a12.8.2025.11.13.07.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 07:38:34 -0800 (PST)
Date: Thu, 13 Nov 2025 16:38:29 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio/vhost: don't consider non-MAP_SHARED regions public
Message-ID: <eg3ny5pnbq535r7bmpxaerljjvp5icyjya5fsiagfoqfqbcykb@hqk3r7vakcpd>
References: <20251113085842.323745-1-d-tatianin@yandex-team.ru>
 <yhrdm2lo5gvbpdn6emn3iwjxu4oa42aol26hoo3j5vnvycvnbx@uwgeim6b257q>
 <66a5228e-1e21-4c59-8538-3475ea3ca768@kernel.org>
 <6wyzsqwlnw2tkkhgfcm62tlen2g56noqaxbau3cn734jsasngo@d5pqtkftefvm>
 <290cc3c5-15d8-40ad-855f-0f9c7c7d405f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <290cc3c5-15d8-40ad-855f-0f9c7c7d405f@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Nov 13, 2025 at 04:27:00PM +0100, David Hildenbrand (Red Hat) wrote:
>On 13.11.25 13:38, Stefano Garzarella wrote:
>>On Thu, Nov 13, 2025 at 12:56:39PM +0100, David Hildenbrand (Red Hat) wrote:
>>>On 13.11.25 10:40, Stefano Garzarella wrote:
>>>>CCing David
>>>
>>>Thanks
>>>
>>>>
>>>>On Thu, Nov 13, 2025 at 11:58:42AM +0300, Daniil Tatianin wrote:
>>>>>Just having a file descriptor is not enough to consider a memory region
>>>>>public. If QEMU didn't map it as MAP_SHARED (in case of share=off), guest
>>>>>writes to this region won't be visible to the vhost-user backend, thus
>>>>>causing it to read all zeroes or garbage. Make sure we don't pass such
>>>>>regions and include that to our definition of what a private region is.
>>>>>
>>>>
>>>>Should we add a Fixes tag? Not really as bug fix, but more to make it
>>>>clear that this is a followup.
>>>>
>>>>Fixes: 552b25229c ("vhost: Rework memslot filtering and fix "used_memslot" tracking")
>>>
>>>I am missing a description of what this problem is fixing.
>>>
>>>The thing is that having real MAP_PRIVATE memory in such VM
>>>configurations is usually a strong indication that it is a
>>>VM-misconfiguration.
>>>
>>>E.g., a vhost-user device cannot possibly read/write that memory.
>>>
>>>So before we call something a fix (that was spelled out as a TODO), I
>>>want to learn more about the valid sue case we have in mind here.
>>
>>I specified in my comment: "Not really as bug fix, but more to make it
>>clear that this is a followup.", so I agree it is not a fix. But, IMO
>>it's nice to link a follow-up patch to the previous patch that
>>introduced the TODO. That said, yeah, maybe the Fixes tag is not the
>>right one, but at least I think we should mention that commit.
>
>Right, the thing is that we already did before the code something wrong
>if you take a look at the old vhost_user_mem_section_filter().
>
>Passing MAP_PRIVATE memory to a vhost-user device and having it work 
>on the shared memory cannot possibly work correctly.
>
>So IIUC, commit 552b25229cf didn't change the behavior, it only 
>highlighted the existing problem.

Okay, now I understand your point and I agree with not putting the Fixes 
tag!

I saw it more as: “Okay, we fixed the TODO introduced there, so maybe 
it's worth mentioning,” but the TODO actually existed from the
beginning.

>
>So I agree, resolving this TODO is great -- back then I wasn't quite 
>sure if there are other things we have to consider so I left it alone.

Thank you for the clarification and discussion!
Stefano


