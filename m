Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274BCE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 17:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNxPT-0001sI-G6; Wed, 18 Dec 2024 12:00:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNxPP-0001rV-13
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:00:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tNxPL-0000yc-Rk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 12:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734541222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h2aO8kmL2KMm8mSXw9LciMurDISEGaiKXTbO0ASy1Oc=;
 b=O1X6pwrviRgO45T8oPAWV+TxS387PRtp4DeSf446InLmmPr53bGtWua9MaDh+b7uzdSiCS
 JY2Y32SyD8BhWmAUozLA/wwl8rHMJBdM9PjJDJ6sGv0Ui0sJtpiFtVQ45h2Z/CUo2mX21b
 GjnjCExawVf5SCCEyNpry5FSoxopD4E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-Ykd2wx4eM6KfzeEH6LM2wA-1; Wed, 18 Dec 2024 12:00:16 -0500
X-MC-Unique: Ykd2wx4eM6KfzeEH6LM2wA-1
X-Mimecast-MFC-AGG-ID: Ykd2wx4eM6KfzeEH6LM2wA
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d87d6c09baso100318446d6.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 09:00:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734541216; x=1735146016;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2aO8kmL2KMm8mSXw9LciMurDISEGaiKXTbO0ASy1Oc=;
 b=pSs7AHmsn1R4PWgdJKh7paBWL0id7ghJboo2UQRrGaLTobH7fuP527jwWeBuJ9cFcu
 UeSdI7vLSajgor4NpszeA2di+pZhDIxee/DEd1T7/92y84KbLNTXqYGYC1MVBHocoyjt
 e64BoM05yHq3AtL2EsGK+7aOwiLXr7IW9XavfiidgPj9rKCs+J49Y43rsq1jOan+DSDq
 B3V3DscZAtGBBc4qvPKgjDbMXbrulW0Cht66kVpt5YHJZ75dDJGgZI84CRTDu0mejSDE
 mAD9KNCPe4F/EFxrsIbbe/RycLquZQM+NepteHv3OX1BbWIWEYNisF5ewgXwSgtGQ+mT
 3krA==
X-Gm-Message-State: AOJu0YxJ2Nw8yFF7YNiU/ujFvHaCUKOg0zn3Ifgh1kz8rdfgqiVmzgdn
 8xShcQk69iLL9lZEjmbp2WXxNw7yD4kGFzO0U993maptkzJxcPpIhYumoj+Z+0ZRZMmPUKTgN4D
 5ducSqgpV6uAUvCL8QQ7V6DP9N3/hqr5ydOhGUsLYRYehGBWBBnA+
X-Gm-Gg: ASbGnctwsA1bvVvUvrom0YrlY0Vywz1Jwa7nB7eYQsUtLCeQe6MeHnX5G23Tfghcwxc
 T/ilA9klLd9bLmG+/l4and5J6JVSZi3YhPz/k5U6bgdzKW11QY1cLm9iDO9NXwYWriD4iHQ1gMZ
 6aTDd2UDfeFlJIM+ZWC7owgFiFQw21YIf8LK8liBo13jptC1g3X4a/tEuD7LjL/KAgaAdxfGzSm
 2AHkqKc6Zen0hjv6mn/8VIJ09EioXT+/p7U77wRuX3MPb8UZAE5vhicPUzquCBWLINTXvIQh6Fa
 JuxNNJ8/it/HziqDkQ==
X-Received: by 2002:ad4:4ea1:0:b0:6d8:ab7e:e54f with SMTP id
 6a1803df08f44-6dd09239f60mr62947736d6.34.1734541215854; 
 Wed, 18 Dec 2024 09:00:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFf5MNbJUflwoLfkhSOEBlaKYFOnX7IkCvHitXx1BNH4TGxp57hsHlRORaunSvB6fyAyF22sA==
X-Received: by 2002:ad4:4ea1:0:b0:6d8:ab7e:e54f with SMTP id
 6a1803df08f44-6dd09239f60mr62946936d6.34.1734541215352; 
 Wed, 18 Dec 2024 09:00:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd38078fsm51727126d6.119.2024.12.18.09.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 09:00:14 -0800 (PST)
Date: Wed, 18 Dec 2024 12:00:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V4 06/19] physmem: preserve ram blocks for cpr
Message-ID: <Z2L_mwAAEjbGRI0r@x1n>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-7-git-send-email-steven.sistare@oracle.com>
 <Z1dOBioqzQmEwW16@x1n>
 <bbb7b4a9-6078-4cb1-89c9-ec2d57b996f0@oracle.com>
 <Z1toIxDzI56ODYcC@x1n> <Z1xREcVCi-hn4BlW@x1n>
 <58935fbe-bb53-457d-b4d6-70c1d7b09e8c@oracle.com>
 <8406c79f-b7fb-4536-8d6a-126bb03a6c9f@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8406c79f-b7fb-4536-8d6a-126bb03a6c9f@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On Wed, Dec 18, 2024 at 11:34:34AM -0500, Steven Sistare wrote:
> After adding resizable support to qemu_ram_alloc_from_fd, I can also tweak it
> to grow the file while preserving error checking for the general case, and
> delete the explicit ftruncate in its caller:
> 
>     /*
>      * Allow file_ram_alloc to grow the file during CPR, if a resizable
>      * memory region wants a larger block than the incoming current size.
>      */
>     file_size = get_file_size(fd);
>     if (file_size && file_size < offset + max_size && size == max_size &&
>         migrate_mode() != MIG_MODE_CPR_TRANSFER) {

Firstly, this check is growing too long, maybe worthwhile to have a helper
already.

file_size_check():
    // COMMENTS...
    if (migrate_mode() == XXX) {
        return true;
    }

Said that, I think it's better we also add the flag to enforce the
truncation, only if cpr found a fd.  E.g. we may want to keep the old
behavior even if the user sets migrate mode to CPR (even without a
migration happening at all), then create a fd ramblock.

>         error_setg(errp, "backing store size 0x%" PRIx64
>                    " does not match 'size' option 0x" RAM_ADDR_FMT,
>                    file_size, max_size);
>         return NULL;
>     }
>     ...
>     new_block->host = file_ram_alloc(new_block, max_size, fd,
>                                      file_size < offset + max_size,
>                                      offset, errp);
> 
> - Steve
> 

-- 
Peter Xu


