Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD94CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 20:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPnpi-0007gD-Lf; Wed, 20 May 2026 16:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPnpa-0007fV-W1
 for qemu-devel@nongnu.org; Wed, 20 May 2026 16:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPnpX-00031y-Mk
 for qemu-devel@nongnu.org; Wed, 20 May 2026 16:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779310059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3vjQ/HBs4fuKnjR58wJ5i41uZXobKHHg0rWWnNHZtws=;
 b=MfOPpyyhRviOnYk+81GJZCmNdgHAhMw+tphwsdpdyOghzYB693gOCxq5h6wuCDgz+F+gkM
 2DxcOgoSQ52uhFlxhYmp4QvCMBl2YOfygbMRxRQhIMpCJisTHe0nTwQ+hJQsyWTWQvRRaR
 tFgJJhRu7IV34a2DdXvfoNdo7XaUVUw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-kqWdwzobM6eMM51a-mssnw-1; Wed, 20 May 2026 16:47:37 -0400
X-MC-Unique: kqWdwzobM6eMM51a-mssnw-1
X-Mimecast-MFC-AGG-ID: kqWdwzobM6eMM51a-mssnw_1779310057
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fb3403e99so35650871cf.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779310057; x=1779914857; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3vjQ/HBs4fuKnjR58wJ5i41uZXobKHHg0rWWnNHZtws=;
 b=TaZmMgcbdrMnEMxsC/muXwEoTa08qApp3AIDkJSkjWc6pKLHlfB9KhbwT+HSYTMdrD
 SwNvSJE8rJjQlkzA/BWASKxiHp9RBi3hw3gGehkjoKAmph95noYMQ/44nvlSXgdanaKt
 pjbJ0Tn2JhfDs15PW4GBE4a1HBhC8DhBpGK3dTwIf6mhxfV4DEoUNPsm6cwMZhcfbQJc
 7j4iHipHLOOpNR5zyxOrDEkrR67JtdUvS6oTLGuU7KVp3245/9reqiGp50D5iES9rb1H
 y1hlZPomxtWbjyOj4i7bl1uPblz4JBUWqDreQoj9rKZd6EMk3dM20dW5AuIRvVzQlvhI
 mJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779310057; x=1779914857;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3vjQ/HBs4fuKnjR58wJ5i41uZXobKHHg0rWWnNHZtws=;
 b=VNDdacnrwO1Z2NnpirEG97URmKoLvAl03v+l2wJxKQWYt/i2Ov09AhOyA6Tcw6Z0Cp
 qYlGBKeRuT7n9MT4Yuibdal0O5mR216urWjMPrF2guHkx2b624uM/q04TbZKh9XOoWRc
 4kogbPeSZFRDR82rKVJXYQ9O6MadOBOr5LMNsVlQTposDxSjwbAlG5rZHwMOSrOXAtiW
 LMy+n15tRyJ30ZRP7YfFU6Y9QwqyDuEPB76hwxzmWnslNyP6Z5CPzcpE1Svut4y4oHoQ
 Gpf+VjZAo8GJpEnOu1bbxoehktrIBoBU/kMwOqHvzqfGavJbpcaBQA1XtwpGlFWvHCho
 DWCg==
X-Gm-Message-State: AOJu0YxbSKl5g45VDZf8giDtFloc/qlyKko4IkGNUOsHo0xXsuNPMhla
 DgbgXUpx4covMkS6MrAIDaZM1+ME+vfCJ0ov5Rce9WQizggSyCrUjExFOwO7s1W05ET5CoJdUWs
 EUh22fyo8cF7YLFqQlpnpwF0Uy4+vHvl6ZbMJgdZzdqZF5b2iXR41BJOr
X-Gm-Gg: Acq92OH7lBlxWCo8FBr67jXzRlTMn7ca/2ixY0DUNWgpuA/agF/fkIles6QDvCraJqp
 T15yH7Q3L4CIdKidMzIyAg68A+3F0keH3NLW1t9i7yQz1+XiEj91JuWZsuFZAP5IC5AQkYpm7tl
 4XNZPYbmZMGpubOpYo7PGS+kpxMWOh85ApdEvOSPt9UM7vTLet+Av5y1h75JPVNsurADACm4UNl
 QhgqNSybkgaeVIei3jLvoUtYpnuBAM/YodGOr3pFrPBb2S71u/qqbF2A36Tuxdkqyt3UUGDpxIa
 cTikMkUZUd7fV5j1JlAjBPU30jrzRzglIX7MZsDgj4cWfCUnz9FSTGJV3LZ8VjFRTjTBZnAAKeI
 Z6TRl0ZZY5RgXexwYFpTx35i8RFlRycYvTA68EErUnOQ+1Dx3AXGqEexG8g==
X-Received: by 2002:a05:622a:190e:b0:50f:b494:7887 with SMTP id
 d75a77b69052e-516c55ba389mr926091cf.51.1779310057205; 
 Wed, 20 May 2026 13:47:37 -0700 (PDT)
X-Received: by 2002:a05:622a:190e:b0:50f:b494:7887 with SMTP id
 d75a77b69052e-516c55ba389mr925681cf.51.1779310056735; 
 Wed, 20 May 2026 13:47:36 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca36096575sm130832466d6.13.2026.05.20.13.47.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 13:47:36 -0700 (PDT)
Date: Wed, 20 May 2026 16:47:34 -0400
From: Peter Xu <peterx@redhat.com>
To: Hy Man <infra.ai.cloud@bitdeer.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@bitdeer.com>
Subject: Re: [PATCH] MAINTAINERS: Update email of Yong Huang
Message-ID: <ag4d5tIOSDfRX-_G@x1.local>
References: <b3bd81c3d9f425bb750a76d7bad7ad0284e55123.1779178180.git.infra.ai.cloud@bitdeer.com>
 <ag4HBdzJXGdKgy50@x1.local>
 <CAFWXh4y9OO6z-5TDtw6GxnzZ19t+SYRn_YNjFFVj2gdpp3cqsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFWXh4y9OO6z-5TDtw6GxnzZ19t+SYRn_YNjFFVj2gdpp3cqsg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 21, 2026 at 03:37:32AM +0800, Hy Man wrote:
> Yes, infra.ai.cloud@bitdeer.com works!

OK, I queued this one for you.

-- 
Peter Xu


