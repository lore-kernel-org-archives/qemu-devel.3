Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC62CEFC4C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 19:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syGCI-0000yL-LS; Tue, 08 Oct 2024 15:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syGCG-0000xy-Q3
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1syGCF-0008HJ-3e
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 15:48:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728416917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RXpaIx73q5I/74lpDfzRABCWO05/NlrPljfcc3PtkuE=;
 b=hpJNMuTbseh/tBOMCRXlTYja8igp9ymH94oYgvPKNF8IwFPJdukKxugNZarM/BlB9TD4uI
 xms2EQiYI4h+szuwEGwkZGn6XDkM4p3l8B3X+ymzzwjYTidXrAHx9cXKUeiLql5cuz16A/
 mEP+Vx8YzpsyLC0mai65c5jkP+vZGKM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-AA-_HGoWN2SY82xBRNFccA-1; Tue, 08 Oct 2024 15:48:36 -0400
X-MC-Unique: AA-_HGoWN2SY82xBRNFccA-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a1a8a4174dso57827025ab.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 12:48:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728416915; x=1729021715;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RXpaIx73q5I/74lpDfzRABCWO05/NlrPljfcc3PtkuE=;
 b=ruvODGA0J8p+1j674v3wEnR/OUbJySaUKiFOv1OdAp//Y2MVCg25/J8PqnPLgvmBpi
 g/Wr1BHlp6Esr+fvft1kqRbiHlILAzAoQLI/JASVdLn3ysVPPyymqnb9bwYl0qBd07tM
 /Iqcwfej6gqN2KjnQ+T2DMfrIXG2AeXdBhxrAKKgSN9XDAkDtXwFbvuiM6yK82eqIR6a
 YjyX11mh+uLQli9PTJYg3mHPjZjbQLlwPipSwi8OZrLxfRVRkmmODDzePPPmiWenMGj5
 xDFqyY11O3upb53KgK6Jb/Ok2xP05HsPMGya1uXZWjurq5uXR3IMo9+tTXcJyP+xfHDj
 /IvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoNkH5rlJoqf0iVfnDWOy2uezj6Jhs69HTM5t4lgyEXGpeONUB6sYVf3FHytS3+kd6fog0WIHTiCgq@nongnu.org
X-Gm-Message-State: AOJu0YwnYhev9IsGbkrXQ544TEf0qr1zuhQdho6zlnFQexyffDamP+q3
 jFJgcUUaeJnngpvL4/2mZCx+jIW3UuCg9TC2FJ+fzfVAQPEuYtzHqdKg2PfhbWYASV7eybotzmY
 egtriW6Ce3uVk02JO8hMwbgKARLsd+d1nibiBLc8rH0JkX+ug1wPP
X-Received: by 2002:a05:6e02:20c3:b0:39f:5abe:ec25 with SMTP id
 e9e14a558f8ab-3a397d10756mr195585ab.19.1728416915466; 
 Tue, 08 Oct 2024 12:48:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0jYJJ4NwsEeKpgkb2xkATPZsNxfmJsfiYYRgkY3hHjbLtJhQ4G0GY0ciQJwZVZTnFuJwShQ==
X-Received: by 2002:a05:6e02:20c3:b0:39f:5abe:ec25 with SMTP id
 e9e14a558f8ab-3a397d10756mr195395ab.19.1728416915171; 
 Tue, 08 Oct 2024 12:48:35 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a37a808befsm20008325ab.42.2024.10.08.12.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 12:48:34 -0700 (PDT)
Date: Tue, 8 Oct 2024 15:48:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
Message-ID: <ZwWMj4FYYpOSnPbe@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-14-git-send-email-steven.sistare@oracle.com>
 <ZwQ6GbVCmitlills@x1n>
 <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n>
 <877caitno5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877caitno5.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Oct 08, 2024 at 04:11:38PM -0300, Fabiano Rosas wrote:
> As of half an hour ago =) We could put a feature branch up and work
> together, if you have more concrete thoughts on how this would look like
> let me know.

[I'll hijack this thread with one more email, as this is not cpr-relevant]

I think I listed all the things I can think of in the wiki, so please go
ahead.

One trivial suggestion is we can start from the very simple, which is the
handshake itself, with a self-bootstrap protocol, probably feature-bit
based or whatever you prefer.  Then we set bit 0 saying "this QEMU knows
how to handshake".

Comparing to the rest requirement, IMHO we can make the channel
establishment the 1st feature, then it's already good for merging, having
feature bit 1 saying "this qemu understands named channel establishment".

Then we add new feature bits on top of the handshake feature, by adding
more feature bits.  Both QEMUs should first handshake on the feature bits
they support and enable only the subset that all support.

Or instead of bit, feature strings, etc. would all work which you
prefer. Just to say we don't need to impl all the ideas there, as some of
them might take more time (e.g. device tree check), and that list is
probably not complete anyway.

-- 
Peter Xu


