Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C910C88E50
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 06:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x60Ph-0007Mx-V7; Mon, 14 Sep 2026 02:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x60PR-0007MC-Qw
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 02:43:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x60PP-0006p3-D7
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 02:43:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789368195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=CTT/16hFC9yGJgnr9klrTPLxwxYTVEjeH6fbS+aYGQ0=;
 b=QYD0KWxoBJi8xFW0+m2xskk8lckbxX4TyCwA6HfuWf8CNpB+dwG6/EXSjNWUWR/PcGV1+h
 wf9bctfgHStEQ5Hzt26F+Z9647M3b5pGmQn0ZCer9T7pq1WTTg7aCRBEfyt9ijqHU0UjlC
 caIahZj21/DPgMXbixL6KdOHBHB/iWY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-203-WsuEZommPli1AdCa7HSNZw-1; Mon, 14 Sep 2026 02:43:13 -0400
X-MC-Unique: WsuEZommPli1AdCa7HSNZw-1
X-Mimecast-MFC-AGG-ID: WsuEZommPli1AdCa7HSNZw_1789368192
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e6862e924so15963015e9.0
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2026 23:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789368192; x=1789972992; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=CTT/16hFC9yGJgnr9klrTPLxwxYTVEjeH6fbS+aYGQ0=;
 b=pLyIc+WcVkekYplMb6NX2Bw/T+juLEHijDT/KyjE3ET1dkGaHQHGqWtMwcHZC5quHQ
 IxGtypBVilFLRSNMqkm4KYWGQke4aO+1iMdOsNx5HcDS7odlLuNKbT6w6B7432PIxFOO
 QZN6jyy5muvaf5lRmYNG1lheeNAe9XMkXkDPQCB0+fpkBt9e6Z2Xdj7PEaQI9FcoZOrT
 Ogm14Xh59q1tDKh176dGcxs1P/s9mRuSOgULDx2BqJjAJx81fT+TLH3tv8ZAVDRZTueo
 T/UDLXeOC7DgMOVL9PH8OkDjwN0eFLzr7RnMJDzFYDj0LsSBqToRiZw/3+JespnY4iBV
 ZWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789368192; x=1789972992;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CTT/16hFC9yGJgnr9klrTPLxwxYTVEjeH6fbS+aYGQ0=;
 b=J1R5u+IXPiIrXwI23zSTo9i9k22AZkUa/oD0l/Rhf7bDKYOmj6gTuQsopvccKS5dDI
 sP4qez9zKqvYQzJ+G4iR8UKdUGw3XIMoMJ05UWwxFSd41wls2ymvOAhnWhqZ/rwd3hMv
 Xxhnl6UDoyU2aQJbti5c84PBjVNK6DxXbJNPQPJIUBkL/4JKx3OlmdXiCtXLxP07tdVt
 X3bTGxQWa9MWcdS3bXUHOSRzrELsIuxoqS4PRfM/fToLv0/Qwaob1Vpljcd8qU1aDEWG
 /HQ8OTZ8emgyjz/NtiHp1Mxg/JY8ELx/wwuHT+/uOVsU13gfk6+6DZqSmyePhTwwetAW
 8P2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwRUlB22IYHhfF7ywTo8Gx9w6bsVd+uY+IO0PtOFV07jwBx+oZkoIKGowPP6CWvwGOhPpaXgul3OO9y@nongnu.org
X-Gm-Message-State: AFuF++kY85FFXWD/zNrzVlAq3tHX3sMODyENxEv+Tx8gQ8gA16myXtyo
 VRBYMMvhp+4hCY1z11kBMaTB+QFk3NKsi5nkEeZCTG1ZlRGvtfAh3diUQIYMVhwsvwXnMsjSt4S
 Av6inqRY83SiDC9QDaIjjZDRCd6CAXsBDA4GSGXb16R8tMYQyWiXzdEwb
X-Gm-Gg: AYBFou36hKMKBS30RaoBdyKpHKApjvCt245XVyM8sP9BcCu5Jqtclt/JPvkkbaFj+8D
 oSe2FaFH5fLhWLYfcDl0tOxlzcIuGcFeao+5y6YIZpHLBcbnz72FQwvW7Cb28/2CemlKhEzIOY9
 +GDYtuze8QugrHiUUgYkWAxiTLj9iv/rTs9Ro/7UtLehK5bz3xUHeu5gnnMTYxQKVo+l9SOITUT
 YctBz6dArIw/3AodqJqiiNQoWYTRqRzOL8So7mQp956UN8DGUHTG8t2i2P4upXCwvrspBBPJz9v
 /hNintfeCa5TeL17mBjwoZNgKfXzfiGJ99ex6eis+d06QSbOwmDrfyC9K4vqCWWb43uib9tt
X-Received: by 2002:a05:600c:37c4:b0:49e:7862:c09e with SMTP id
 5b1f17b1804b1-49e7a656db2mr13413425e9.14.1789368192435; 
 Sun, 13 Sep 2026 23:43:12 -0700 (PDT)
X-Received: by 2002:a05:600c:37c4:b0:49e:7862:c09e with SMTP id
 5b1f17b1804b1-49e7a656db2mr13413155e9.14.1789368192072; 
 Sun, 13 Sep 2026 23:43:12 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.51]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e71e300f3sm195576235e9.7.2026.09.13.23.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2026 23:43:11 -0700 (PDT)
Message-ID: <57431f7c-fcdc-408e-b6a2-9a255315c882@redhat.com>
Date: Mon, 14 Sep 2026 08:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: The CPU_RESOLVING_TYPE is not fixed for x86_32 and x86_64. is
 that proper?
To: luoyonggang@gmail.com, qemu-level <qemu-devel@nongnu.org>
References: <CAE2XoE_=G5Ri9p23vJRX3iJMHSDH4Ec+0vWWbVNf4DksxtbG2A@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAE2XoE_=G5Ri9p23vJRX3iJMHSDH4Ec+0vWWbVNf4DksxtbG2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 13/09/2026 07.45, Yonggang Luo wrote:
> #define CPU_RESOLVING_TYPE TYPE_X86_CPU, and TYPE_X86_CPU is vary for for 
> x86_32 and x86_64. can it define TYPE_X86_CPU to be a fixed 'x86-cpu' like 
> other arches?
TYPE_X86_CPU differs depending on whether you build the binary that targets 
64-bit guest CPUs (qemu-system-x86_64) or the binary that targets 32-bit 
guest CPUs (qemu-system-i386). You cannot easily change this without 
breaking migration from older QEMU versions.

What's exactly the problem that you have run into that led to this question?

FWIW, I once proposed a patch series that allows to integrate both target 
types in one binary:

  https://lore.kernel.org/qemu-devel/20260402095132.29245-1-thuth@redhat.com/

... however, I unfortunately failed to get the supporting attention of the 
x86 maintainers, so this has never been merged.

  Thomas


