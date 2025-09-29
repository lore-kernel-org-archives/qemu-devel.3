Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E59D4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GFs-0002d9-Nq; Mon, 29 Sep 2025 11:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3GFo-0002aI-KN
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:57:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v3GFj-00028h-Qd
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:57:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tH0EYQCMW+X4twrDNFLhRUBLXaBtMB/WAmJFzMljt/g=;
 b=D1zvFldAgIyfBAR4GaFpTsFhrgxrVVk3NqH4uV3Hr0Ikbxb+ZGs5RY0HqdM4wcgzGFn48j
 V3H8g/tJgzo3+O+YkuHOWH86+0tQaDLYIZ9WMRWdAKXVbAz788hCSPYfoVmre891xQ5Ua5
 vZWGYssAOrS4w7Y9KwtT/8h/xhV5gNs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657--BxSpQwKPVKubaD--sztIw-1; Mon, 29 Sep 2025 11:57:20 -0400
X-MC-Unique: -BxSpQwKPVKubaD--sztIw-1
X-Mimecast-MFC-AGG-ID: -BxSpQwKPVKubaD--sztIw_1759161439
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-856c1aa079bso1109859685a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:57:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161439; x=1759766239;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tH0EYQCMW+X4twrDNFLhRUBLXaBtMB/WAmJFzMljt/g=;
 b=OnWNNgX1sCdxVwepiLvydt5IiLrTJuKJPVac7WGXOaj3iY2D4lozOqF8jZGIYjinMa
 CzorEqq9BEEcc+uAJ/szw/52gb7EiBCBCMzPL2Linc/NmwyxjUqKQ9MCvINVNYSeoVeT
 ALvNNpKCmGkj5HBc9v1w/SUP+XC9V9qPhJkhRoS7mgv/uxqrMZRMvDTM562lKMthrYKP
 Qa6P3UKzNIP5PBtQb+XrwPcFnqWT+u1y3RGqenF5qsFv9C7catnKZat1zjzapgoq85gD
 u/Q8c57plyYLWBRMwlbMxRt7Cxw8aTGFK8eMmtqO9QOiONeTjw9e8VC9XcFCeuBvqwMc
 /rbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlNiJ8ZgbjfpRunpZOrTdCJbf52DPT2vCKBX7awbAIg2VjY3/3ihej7/yraknEcT8phawkS6tWCgRt@nongnu.org
X-Gm-Message-State: AOJu0Yxji+KVUywIRzyGmQeukRsKS1XC1O7rULaE5+aIM2H4ZZ/Hpjvg
 c64gX7vcMwFcD67Q52StLhYH4I2CCNb4cqQrW2seLgNsNAMY3zJSUiLanqzZyu9W6VD3vQ7uW0/
 MZxIJodI/nSL6/weAwYW3JJwStKEz3lj8f5ZgswMpcshkzqKWsqYectoxMcH+oS6Y
X-Gm-Gg: ASbGncvgzbZHkthh3JXc8UgIX6+uP3JcBWnrX5ITUaphiy+Q6lXdd/YXNwaxfL6biwr
 ac/3hhSk5YCilE13keOCyMEup6E6CifuDq4rb/vpKWiHSLwqDNkzK6rtEojzaFHtFHyuMZTpEjC
 OtNasDHX77eZSbMpkZmf4k0WVc9EFHZOYj46NsVkbjSNgM7/ePqq1Wc9qOYDULE9kEHV+ToPaM1
 JrCW16f60bFUVQh5aSkdeneLSTgdzRc2/MjWzIdmva+QxPcnhMnK+CFggzhMQ+aksP/Li/vK0e1
 /6WjMPScXLmyVJD+ebLSmww7ueXXqSEQ
X-Received: by 2002:a05:620a:c45:b0:848:1a44:cf9 with SMTP id
 af79cd13be357-86eecbeba94mr142822385a.41.1759161438922; 
 Mon, 29 Sep 2025 08:57:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2okpHqG+bdf9Q5GYNl8sPUANn6jhJVk+B4zaTIp0hhfsVJ91AGMQtpG/t0eSdMghALkfAIA==
X-Received: by 2002:a05:620a:c45:b0:848:1a44:cf9 with SMTP id
 af79cd13be357-86eecbeba94mr142818785a.41.1759161438342; 
 Mon, 29 Sep 2025 08:57:18 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-85c2a1913d5sm841708285a.31.2025.09.29.08.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:57:17 -0700 (PDT)
Date: Mon, 29 Sep 2025 11:57:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Fabiano Rosas <farosas@suse.de>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] migration/vmstate: remove
 VMSTATE_BUFFER_POINTER_UNSAFE macro
Message-ID: <aNqsXPt3LGJv4F1O@x1.local>
References: <20250802142115.41638-1-mjt@tls.msk.ru>
 <20250802142115.41638-2-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250802142115.41638-2-mjt@tls.msk.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Sat, Aug 02, 2025 at 05:21:09PM +0300, Michael Tokarev wrote:
> The only user of this macro was VirtIONet.vlans, which has been
> converted to regular VMSTATE_BUFFER.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  include/migration/vmstate.h | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1ff7bd9ac4..ec0946c2aa 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -702,15 +702,6 @@ extern const VMStateInfo vmstate_info_qlist;
>      .offset     = offsetof(_state, _field),                          \
>  }
>  
> -#define VMSTATE_BUFFER_POINTER_UNSAFE(_field, _state, _version, _size) { \
> -    .name       = (stringify(_field)),                               \
> -    .version_id = (_version),                                        \
> -    .size       = (_size),                                           \
> -    .info       = &vmstate_info_buffer,                              \
> -    .flags      = VMS_BUFFER|VMS_POINTER,                            \
> -    .offset     = offsetof(_state, _field),                          \
> -}
> -
>  /* Allocate a temporary of type 'tmp_type', set tmp->parent to _state
>   * and execute the vmsd on the temporary.  Note that we're working with
>   * the whole of _state here, not a field within it.
> -- 
> 2.47.2
> 

I'm scanning over lost patches on the list.  I suspect this is lost when
you sent v2 replying to v1.

Wanna repost with a full v2 to catch Michael's attention once more?  I also
always would suggest a cover letter..

Thanks,

-- 
Peter Xu


