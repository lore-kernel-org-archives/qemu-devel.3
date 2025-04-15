Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71B4C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 10:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4dTn-00020R-KT; Tue, 15 Apr 2025 06:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4dTP-0001yt-7q
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:24:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4dTN-0000Z6-Di
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 06:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744712696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zrg4Ec95yXT9M/v+mAI8JiD8Q/5mRhaBv4gvVhxv5+U=;
 b=blHTUrTaoOxpaTOoBmC+ARk0D51POoVEm5YLqCEnR6r93YRF6TxFlFHXs3+8viqdYjESnN
 H+5VUn4AFPBzlIxqiDhR/9qCbmrmNXRYps3k/GobopttOqqbmmeS0oeQz195EUbS6SPsLw
 hqtOSwlJ7XMb9BTbWW2RYbEYDgeC1So=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-DlNfMhK3PkSSRznDkUJwNA-1; Tue, 15 Apr 2025 06:24:53 -0400
X-MC-Unique: DlNfMhK3PkSSRznDkUJwNA-1
X-Mimecast-MFC-AGG-ID: DlNfMhK3PkSSRznDkUJwNA_1744712693
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-39131851046so1951636f8f.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 03:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744712693; x=1745317493;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zrg4Ec95yXT9M/v+mAI8JiD8Q/5mRhaBv4gvVhxv5+U=;
 b=Mp5RBewozJVOPvS7AwP47gLomiT1t6bgsudhKlhvpiRE5RaRDzdtOwBkXrQWfA6o0k
 hMlNPqtrR+C+U8dncE1xDWm77nxNXZ3ov0aBVQd3Emz4UJMU6LvpVSmraYUirXidm+wR
 zYOnb0nIoANRhMOb6CVoV44Q/C7F2zGP18kRdusLiq6G9sd4OV15NEL4jm5Gt+5SeQ4k
 s4MDB0nMq6q4KvgsSm1KnNA7PWuua+yq31jXj7BHCfeG4sSVjz8jhF2HxBK/apCiYo13
 waMmWzp3zvloAxY9hk+hEizN1XsfrlApo0ElUI0D7KYKRRVY028MWIa2GkEo7/M0LQjy
 jaCg==
X-Gm-Message-State: AOJu0Yxn7secW98BWC1owm5vURaPItau2645tAeZU86IYnni5kuVPFb1
 L0UDDCia1VrUpCRGOAYYf28Dy+LJ07WyT69OMv8mRjaZpkRe95qtMogB25/6hmytA+xR4qgmjZ9
 jcrJCOXsuGmO1XSZS6zSt5iCvDVmQBs8NOdTm6xES+IgAqH2JmaJs
X-Gm-Gg: ASbGncs6XlsI0DeNkKMTogAnqPJIUzyd1EndtFBnx2pztpNUeuzbfrT85DzsRE3GsRW
 Hz5bZKQSHGg9iOsu3IzZIRdG8YW+4p+vEZOWG4M3kqRCMgY7DB0iOL/VH2F1BTXcqCOypKuqrJH
 lbd4m6mnRMWYw/Mvt/1v0dUVVGYDCvi5c/u509LKVK2/SD/jIUMqNV5lsKUcbkF+nzwgqb2VRfu
 MxiBSIFMCoFURIX/J9o8tcpVucRygD0BKZuRBg+nHhbXr7KqHc9KRH+Py0GNYPncxapFWp4WfJ7
 VzKEbuf71+4Q49SZ
X-Received: by 2002:a5d:5f82:0:b0:39c:1257:dba8 with SMTP id
 ffacd0b85a97d-39eaaed2b4emr14351612f8f.56.1744712692739; 
 Tue, 15 Apr 2025 03:24:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlTzk/iNqCXrFnFDcUEsQ3j9gPt6rjC+cbunzCquWuo4nOPl87PzvcM53ZROnjphzGDXhUTg==
X-Received: by 2002:a5d:5f82:0:b0:39c:1257:dba8 with SMTP id
 ffacd0b85a97d-39eaaed2b4emr14351598f8f.56.1744712692367; 
 Tue, 15 Apr 2025 03:24:52 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-39eaf43cccdsm13768037f8f.79.2025.04.15.03.24.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 03:24:51 -0700 (PDT)
Message-ID: <57d8e9f6-01dc-4a11-861f-96906d302199@redhat.com>
Date: Tue, 15 Apr 2025 12:24:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/9] rust/hpet: Initial support for migration
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>
References: <20250414144943.1112885-1-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250414144943.1112885-1-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/14/25 16:49, Zhao Liu wrote:
> Hi all,
> 
> This series add the *initial* support for HPET migration.
> 
> This is *initial* because the current migration implementation
> introduces multiple *unsafe* callbacks (please refer Patch 8).
> 
> Before the vmstate builder, one possible cleanup approach is to wrap
> callbacks in the vmstate binding using a method similar to the
> vmstate_exist_fn macro.
> 
> However, this approach would also create a lot of repetitive code (since
> vmstate has so many callbacks: pre_load, post_load, pre_save, post_save,
> needed and dev_unplug_pending). Although it would be cleaner, it would
> somewhat deviate from the path of the vmstate builder.
> 
> Therefore, firstly focus on completing the functionality of HPET, and
> those current unsafe callbacks can at least clearly indicate the needed
> functionality of vmstate. The next step is to consider refactoring
> vmstate to move towards the vmstate builder direction.

Merged 4/6/7/9 for now, thanks! I'll reply to patch 2 with a review.

Paolo

> Test this series with 3 migration cases:
>   * q35 (Rust HPET) -> q35 (Rust HPET)
>   * q35 (Rust HPET) -> q35 (C HPET)
>   * q35 (C HPET) -> q35 (Rust HPET)
> 
> Thanks and Best Regards,
> Zhao
> ---
> Zhao Liu (9):
>    rust/vmstate: Support field_exists check in vmstate_struct macro
>    rust/vmstate: Support varray's num field wrapped in BqlCell
>    rust/vmstate_test: Test varray with num field wrapped in BqlCell
>    rust/vmstate_test: Fix typo in
>      test_vmstate_macro_array_of_pointer_wrapped()
>    rust/timer: Define NANOSECONDS_PER_SECOND binding as u64
>    rust/hpet: convert num_timers to u8 type
>    rust/hpet: convert HPETTimer index to u8 type
>    rust/hpet: Support migration
>    rust/hpet: Fix a clippy error
> 
>   docs/devel/rust.rst                  |   3 +-
>   rust/hw/timer/hpet/src/hpet.rs       | 189 ++++++++++++++++++++++++---
>   rust/qemu-api/src/assertions.rs      |  30 ++++-
>   rust/qemu-api/src/cell.rs            |  23 ++++
>   rust/qemu-api/src/timer.rs           |   2 +
>   rust/qemu-api/src/vmstate.rs         |  67 +++++-----
>   rust/qemu-api/tests/vmstate_tests.rs |  45 +++++--
>   7 files changed, 294 insertions(+), 65 deletions(-)
> 


