Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B8EBE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 17:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKhgI-0006gf-Dn; Mon, 09 Dec 2024 12:36:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKhgG-0006gN-HB
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:36:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tKhgE-0007eD-38
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 12:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733765780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iD8PhBZGbEdZwr668dz4bV4OKhzgCm3xvZGrB2naa9g=;
 b=JrH24GD9mgW3yVjjmF8AJnXjI3am5a6qwv0G83qSHELXG3N4m6gECcJb717MERevUCNPzM
 f7KuU6dG7gyx1OYfuLDUs1rgeEyMYu+nMIkQ5LzAP4p5rPFJRZtyJv22HxhIOWEN50NBkw
 dIbTa/8/wdhMz9taTsQWSExq90sTwao=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-OASvjy1QPk2FZZ991PG6JA-1; Mon, 09 Dec 2024 12:36:17 -0500
X-MC-Unique: OASvjy1QPk2FZZ991PG6JA-1
X-Mimecast-MFC-AGG-ID: OASvjy1QPk2FZZ991PG6JA
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6cfc8fc17so279877285a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 09:36:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733765777; x=1734370577;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iD8PhBZGbEdZwr668dz4bV4OKhzgCm3xvZGrB2naa9g=;
 b=npNR8jMxUnj09SuELM5/cntGIUGOkFrjeVzzlyws8QgBduxQzvK5o9ZZr2mf2atthu
 lyEfmz1LRzvt20uD2Co1eKTwebKNmL8guowyZEDt9gSX4zHfX2SW0v0PACqpmx6fHjC9
 gzYzYAF+xIB1FNBle0bJrtU0AfkBgQyvry3puC3Pw7R9JoJKOCJyl3exapNBNe3Vd1w1
 Gw2Iq6DLdWLJbPgvEFjFDtPjJhqtN/csZTsZf0TrQBVMEipi1Ek22PKqt695/ihBy1/M
 97QnLwzGNZLgJ7YfITIinVrVC2S7GYgvz0Gq7iAhggr2KiqnKZQPXDfPMM3grfu+gBkD
 InPw==
X-Gm-Message-State: AOJu0YycCwHoSMorQkyiwiYPaGFPEAMqqefZUcs6GI+wS1d5Dp3pMaUN
 LCRchqTD+SSQN7LO9qV/+YzGzP3iXXb5pmhwGe019HbF5DdFk5pA5EDxqkxu7TIGfTQn3x3yrdk
 dUCmefNVCr9NagqK6RERTr2h2HVJRh9IwO9R0kcZnU0jzOOFH9zO8
X-Gm-Gg: ASbGncs2zln6jSWCVJU82tY5tct1GP9PBe+vHl1gFw+ZfTuABcWIHEaP9ThWiIZcwVX
 vE9MeOpJwgqa0PAt+raIAjT3kbuwMwjCl5DICmKqVph5H1aJWoqsQOPA7pg9sWxrBQJdF67GJsZ
 hAFSj9Pt0+BpxEDhQ3vbQ9FAvRx1fhjClWcaclrQ9sSaka81XDO0JN0rpTlKc9n5XKxythJUOZW
 rToW+JOXE64busNORO6ZCVau2CH7fQ655f248VjcnsNRnsa+HAyCPfF0GTimAI/i2UAGh7pU92F
 XovR3xoJm7w=
X-Received: by 2002:a05:620a:2405:b0:7b6:d754:2085 with SMTP id
 af79cd13be357-7b6d754226cmr503612785a.28.1733765777295; 
 Mon, 09 Dec 2024 09:36:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGls3vpSfHSc/jZlLdayM9Ja1lw3Rble9PeEeWW2JOmFcCHHt78P28lEcZFtrSQdANnPICZ8g==
X-Received: by 2002:a05:620a:2405:b0:7b6:d754:2085 with SMTP id
 af79cd13be357-7b6d754226cmr503610085a.28.1733765777017; 
 Mon, 09 Dec 2024 09:36:17 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6d2bdad75sm150647385a.83.2024.12.09.09.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 09:36:16 -0800 (PST)
Date: Mon, 9 Dec 2024 12:36:14 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 01/19] backends/hostmem-shm: factor out allocation of
 "anonymous shared memory with an fd"
Message-ID: <Z1cqjgcvKuUf-zfj@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1733145611-62315-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Dec 02, 2024 at 05:19:53AM -0800, Steve Sistare wrote:
> diff --git a/util/oslib-win32.c b/util/oslib-win32.c
> index b623830..aef5779 100644
> --- a/util/oslib-win32.c
> +++ b/util/oslib-win32.c
> @@ -877,3 +877,14 @@ void qemu_win32_map_free(void *ptr, HANDLE h, Error **errp)
>      }
>      CloseHandle(h);
>  }
> +
> +bool qemu_shm_available(void)
> +{
> +    return false;
> +}
> +
> +int qemu_shm_alloc(size_t size, Error **errp)
> +{
> +    error_setg("Shared memory is not supported.");

May need a fixup here to make build pass.

> +    return -1;
> +}

-- 
Peter Xu


