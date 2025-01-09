Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591C9E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVtQt-0005k0-55; Thu, 09 Jan 2025 09:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVtQr-0005jo-Kp
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:22:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVtQq-0002Mq-3u
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736432563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/D/jq/w3AQBawSwoGIqPduPOHfK1v/fhJ2+g7v2eKCY=;
 b=UceRmiSXnCED2Ex9ui+A21T3gsnZjWeF6TROlXTbooKHGnoLZ4dUkrDWHiqnUZlh6gdfuz
 Czku35oGnSTU3634m4284dtrbQuiLq+9u3rfHTGKsr54odvD/Nn6jNg4idxxIsd1IB0LCG
 dHcxsh7azliGq6YhV65goeWsXqO2YU0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-cabidH4zOYK9IFByvXRKbg-1; Thu, 09 Jan 2025 09:22:42 -0500
X-MC-Unique: cabidH4zOYK9IFByvXRKbg-1
X-Mimecast-MFC-AGG-ID: cabidH4zOYK9IFByvXRKbg
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b6e852eeabso153433485a.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:22:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736432562; x=1737037362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/D/jq/w3AQBawSwoGIqPduPOHfK1v/fhJ2+g7v2eKCY=;
 b=SZWHmTlQpsdeNC3Up/42AuOefuk0YUHeeQjV+ha6iVybwWl8TpTyRYwBWmwn/tR2cz
 ceiQpqv5vZ6bhGt9R2VNTeCy8xcFW54mfk7k/rgbk9evERC3j6z9/u4qSgapSmYpkXG0
 UPFa7fQErZkThRQ378SMeplSBnLLusjWMy7WKZszRggq3o9ZYQA1mhDta4USvI+1xEtV
 jqbxBCj1V4P/Aj/vLBumdEcfBOrV5sg19z5yzS15Y8Y4veVLh0KLKhLHcubmS3Wc/FmI
 6hou/SFAzhAwkDog6XpGJWFNa6l5Xz2O5R64OT1Y0UqfVHOqn6uCkgE3A7toRW9+y57t
 RHiw==
X-Gm-Message-State: AOJu0YxxrNoPmJfKotxEgkaHB458/80SGIrFW6msWtg0Uke/4g2mWALr
 wQbgq0XvblAmWQYUbAfXs/xM4QDFxozBu4K40BW4mMeMtfGJRTsNJhs2ojCu+AIlTaQbrrnPJpK
 L7DkKtOP05lHmLJG/GyQyz7bUKJQJywjJ3jodi4ay+oZoVL1ztGjD
X-Gm-Gg: ASbGnctUc1tjUQ829/Aj005bVILTZsM/Spu1lbd4Lhh/1O8AwNwWnPvNmfO5xcnD834
 YfqWso6qAsmHansJBNSM5pQiLePL64XUPAD35CAYnm5y0B60EMczl+GoM7/bCtnQKRNKI/Q70At
 uc1dmQ4FYcFGPQAMKPhzYyvlVyK7UNmvoRu7qtJp7+1n3J8tCFgqu6LglsrA97svstYtPuq4l/i
 tSB1VzsLm25ZnV+ozl6xWmYB9yxWLdeSCk15ToncQPbLkbk7HkT0QqBQ4xQcBbYZMfpqsRW3tKu
 GTQNVZCZmnj+v5Awug==
X-Received: by 2002:a05:620a:a016:b0:7bc:db11:4945 with SMTP id
 af79cd13be357-7bcdb114b95mr759575285a.51.1736432561915; 
 Thu, 09 Jan 2025 06:22:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZ9ysB7ZOq+AKl9SRVa0oBM2Gr24EgjTQfjHRxLteXDZNXCTdQXGttVJmwckSBgt3WyY0HrA==
X-Received: by 2002:a05:620a:a016:b0:7bc:db11:4945 with SMTP id
 af79cd13be357-7bcdb114b95mr759572785a.51.1736432561576; 
 Thu, 09 Jan 2025 06:22:41 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce327b8besm71277585a.59.2025.01.09.06.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 06:22:40 -0800 (PST)
Date: Thu, 9 Jan 2025 09:22:39 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 4/7] migration: Rename vmstate_info_nullptr
Message-ID: <Z3_br0JVQ0F_Zas6@x1n>
References: <20250109140959.19464-1-farosas@suse.de>
 <20250109140959.19464-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109140959.19464-5-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.436,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Thu, Jan 09, 2025 at 11:09:56AM -0300, Fabiano Rosas wrote:
> Rename vmstate_info_nullptr from "uint64_t" to "nullptr". This vmstate
> actually reads and writes just a byte, so the proper name would be
> uint8. However, since this is a marker for a NULL pointer, it's
> convenient to have a more explicit name that can be identified by the
> consumers of the JSON part of the stream.
> 
> Change the name to "nullptr" and add support for it in the
> analyze-migration.py script. Arbitrarily use the name of the type as
> the value of the field to avoid the script showing 0x30 or '0', which
> could be confusing for readers.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/vmstate-types.c    |  2 +-
>  scripts/analyze-migration.py | 22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index e83bfccb9e..d70d573dbd 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -338,7 +338,7 @@ static int put_nullptr(QEMUFile *f, void *pv, size_t size,
>  }
>  
>  const VMStateInfo vmstate_info_nullptr = {
> -    .name = "uint64",
> +    .name = "nullptr",
>      .get  = get_nullptr,
>      .put  = put_nullptr,
>  };
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index fcda11f31d..134c25f20a 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -377,6 +377,8 @@ def read(self):
>  
>  
>  class VMSDFieldInt(VMSDFieldGeneric):
> +    NULL_PTR_MARKER = 0x30
> +
>      def __init__(self, desc, file):
>          super(VMSDFieldInt, self).__init__(desc, file)
>          self.size = int(desc['size'])
> @@ -385,6 +387,16 @@ def __init__(self, desc, file):
>          self.udtype = '>u%d' % self.size
>  
>      def __repr__(self):
> +
> +        # A NULL pointer is encoded in the stream as a '0' to
> +        # disambiguate from a mere 0x0 value and avoid consumers
> +        # trying to follow the NULL pointer. Displaying '0', 0x30 or
> +        # 0x0 when analyzing the JSON debug stream could become
> +        # confusing, so use an explicit term instead. The actual value
> +        # in the stream was already validated by VMSDFieldNull.
> +        if self.data == self.NULL_PTR_MARKER:
> +            return "nullptr"

What happens if a real int field has value 0x30 which is not a marker?
Would it be wrongly represented as "nullptr"?

> +
>          if self.data < 0:
>              return ('%s (%d)' % ((self.format % self.udata), self.data))
>          else:
> @@ -417,6 +429,15 @@ def __init__(self, desc, file):
>          super(VMSDFieldIntLE, self).__init__(desc, file)
>          self.dtype = '<i%d' % self.size
>  
> +class VMSDFieldNull(VMSDFieldUInt):
> +    def __init__(self, desc, file):
> +        super(VMSDFieldUInt, self).__init__(desc, file)
> +
> +    def read(self):
> +        super(VMSDFieldUInt, self).read()
> +        assert(self.data == self.NULL_PTR_MARKER)
> +        return self.data
> +
>  class VMSDFieldBool(VMSDFieldGeneric):
>      def __init__(self, desc, file):
>          super(VMSDFieldBool, self).__init__(desc, file)
> @@ -558,6 +579,7 @@ def getDict(self):
>      "bitmap" : VMSDFieldGeneric,
>      "struct" : VMSDFieldStruct,
>      "capability": VMSDFieldCap,
> +    "nullptr": VMSDFieldNull,
>      "unknown" : VMSDFieldGeneric,
>  }
>  
> -- 
> 2.35.3
> 

-- 
Peter Xu


