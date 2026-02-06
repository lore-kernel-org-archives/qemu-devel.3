Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB376EE2091
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 12:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voKsy-00016P-1b; Fri, 06 Feb 2026 07:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voKsw-00016F-P5
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:24:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1voKsv-0003V8-9K
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 07:24:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770380668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g1ycejH9uRGxl9DH88CZzwcBUpRfX4ZMAgGeWliNa1c=;
 b=I3+PPLeBKodrk47L5OtL1L6bvbzb5xWiwej2t0iKEaLiHCM73CwQYwHs7oBcQm9gQlhyNe
 BRelu34AxuiTfQCZ6kiD2goLdPcyHFDFDLcPxhUAXfaR0LJiAfYuU+mnJHHy/VhWZsgW9+
 LryvutHy7nUCvXT8DJXYcfAKlRyjxeg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Om8bwFfWP8CbDwhDwTzT6Q-1; Fri, 06 Feb 2026 07:24:26 -0500
X-MC-Unique: Om8bwFfWP8CbDwhDwTzT6Q-1
X-Mimecast-MFC-AGG-ID: Om8bwFfWP8CbDwhDwTzT6Q_1770380665
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483101623e9so25193075e9.3
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 04:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770380665; x=1770985465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=g1ycejH9uRGxl9DH88CZzwcBUpRfX4ZMAgGeWliNa1c=;
 b=huu9jD9nCNYN0kwWIee9loX/o17tqSoHedmZFH2E+u5iG9ne7vdpavLvTI1IdxsOVz
 g+OHOQa/kpl97ISbfLOLnWn2ljU79OThIZGIIiOTPiYDGNKDZazlhilhv2p14UwAO36z
 /HqItmULZ64X/+kotmZ0+8vGeag5nVBovtZSSdkRAvGwZ32agbmlgdfDzbf6AgIkSdNt
 mFo8SuXhgpNhaNknX0eqIiFVkAj5MeKDpC7JCAu6w2CGrw6rwBEt8H+aKSnoNxjuHAdu
 K/64vb5F6wbgDVVyitYzvE7O2L0SlQ4QZ0d1igq7zQ8I8GVKLILeMEHe39MbrlW+YCR6
 nM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770380665; x=1770985465;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g1ycejH9uRGxl9DH88CZzwcBUpRfX4ZMAgGeWliNa1c=;
 b=PhjYJFIcsPUvJy0tmHhdD/sEd9WRdq5IqYSmUDetMoOAdnwIJevCc5qEvb3H92QL1B
 IqvqvwZgxWz1ypiWO6vwjpxWrbtQPP45tlXOxhP2E3o9CM6AZx1pJrHA9DPgmlS9thgH
 IgkxVtoFNtZhxB+9YnqucaG9mmwITGcnDTElMFrzBUMS/pcHA4U1bjO93oc/sLpzStlJ
 xUEYzkTh0YpWgNAWKNDZj4tXaCfjWUPS9sr3c2RvUdgrSoiL7826pHQ4e0Vakxwo+MQP
 XgicV9GIpdGrof46V+CqsAmgE+3/B7A7jvI8e7+hIq84qyGiR5rRQIQY85gbjMKdrrMW
 TRng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhyrRejuOC6eN1DFVcVp7Gtq5VJimJFj1DkI8E8SiVec+nJ4N80ZlkMicfyy4UUsoy2vuojWXRZH/C@nongnu.org
X-Gm-Message-State: AOJu0Yw2zruV7/HJ5oUodfsGwWnYyvReeSDCNm4AsFrOSiWGDEz8lN/b
 7XhO9aREUR7fVWP/Hmbga9hI6JJQGzJ2LTcZMAo/GNh3NzUdeA+9RSfk4RjplYy+l3jvcuCW8Xb
 kUP5hFM9xQ95SxVGZnQigqypARKo2scug7aySaYUO6WGp3p6WMGjZi2F4
X-Gm-Gg: AZuq6aJwXwTcNN2ORqhn2MtEora1/p9nKLxZOqgDvpNQUzli9IzX84dUJcHML5SdWQh
 U47OvW0HI7feOE4ZRveivarjZoHc/P/Lt8QArWfvb+4iS/83b5S8tvYQgRh3dg616LPlGjAOwcQ
 ZcjKOj9xpR8oZ3XoCW7Y9ojg7KCZwNk2HeMX4T6IxOMYJyb8NIg1yxDqrAGzjflvhyF5vRbvipe
 fYSuY2pLELJsY2hix27Nx9FOfb7+NCDbB17IdxVjF6vfGgO0xUyeT9A/GylXsnfzCIeRFZigbkh
 7rDaJLtnzNof5vz7u046U7If7+jaHrFH+HosFRajDmzHT8h+5VVE0UChbfOB3S3gwqyYwbs8mrB
 hI+pry8c=
X-Received: by 2002:a05:600c:4450:b0:480:699c:abe9 with SMTP id
 5b1f17b1804b1-483203398a7mr35888565e9.37.1770380665472; 
 Fri, 06 Feb 2026 04:24:25 -0800 (PST)
X-Received: by 2002:a05:600c:4450:b0:480:699c:abe9 with SMTP id
 5b1f17b1804b1-483203398a7mr35888265e9.37.1770380665073; 
 Fri, 06 Feb 2026 04:24:25 -0800 (PST)
Received: from [192.168.0.9] ([47.64.115.203])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4832041f1a3sm25084615e9.7.2026.02.06.04.24.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 04:24:24 -0800 (PST)
Message-ID: <c90374ee-5ffa-4fd0-b671-b5c55b0bf57a@redhat.com>
Date: Fri, 6 Feb 2026 13:24:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] tests/functional/migration: Use the migrate_vms
 helper
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com
References: <20260204172332.21367-1-farosas@suse.de>
 <20260204172332.21367-4-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260204172332.21367-4-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 04/02/2026 18.23, Fabiano Rosas wrote:
> Change do_migrate() to call the migrate_vms() helper and provide it
> with the two VMs already created. Rename do_migrate -> migrate and
> adjust the callers.
> 
> While here, standardize on the "src" and "dst" names.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   tests/functional/migration.py | 34 ++++++++++++++++++----------------
>   1 file changed, 18 insertions(+), 16 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


