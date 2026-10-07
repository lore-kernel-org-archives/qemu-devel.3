Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338AFCA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:18:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xETOt-0004OD-3a; Wed, 07 Oct 2026 11:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xETOq-0004Mf-RQ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 11:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xETOo-0006sh-82
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 11:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791386260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X4nUOsQhLXZeWCIVa7oEUi8RfHcyMHhnEr9t9jCy45Y=;
 b=BO1oH1Nz1xToUPZocPYl41f4/dow1XylBuC43uU0OcWviVVWvComAoV3fZfdR/dAWMKmCg
 dymevjJERYzl1apF8+saEjj+xX0S8GpWnmvzLds13BrhdUwBFIsXV3bFXdPX6rtTbjmOtL
 k8swW0FWoeeua9OPHVQ8NTjRcMmu7EY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-P1zoJEsyOt2icirPABX7OQ-1; Wed, 07 Oct 2026 11:17:39 -0400
X-MC-Unique: P1zoJEsyOt2icirPABX7OQ-1
X-Mimecast-MFC-AGG-ID: P1zoJEsyOt2icirPABX7OQ_1791386258
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48b028d93c5so2436896f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791386258; x=1791991058; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=X4nUOsQhLXZeWCIVa7oEUi8RfHcyMHhnEr9t9jCy45Y=;
 b=XDVuyQGEHt27hX6FlbWrP+akrKElOu2tsipauA0KbyCIiG6N/LOHKKMf+R6nfuVlSw
 NlOAHqOE9fHuw1npNgTJkh2/8Wt+3ZB6Wuu3zsdWyu0EeAZOmdvae7KaOC/z0MqmXDlm
 o00j+WFXVSvsFS7pPuvrTv64MJ5jacqGuCG9iIK/P2DZy10/8eJsvY74K+dvLVQWFC+q
 Y/4MSL+L8y/DhkE70mefKkksMcZ57VaDElbrwiQZc7Cju3LqjTGvVz+fiE+hrJiYFeLs
 n7ftUd4jSZYQtNfa3HmWyXnyhua/270rRLZHF46FSPxtwbkem7UCmiDZGREg4O8baD8W
 FtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791386258; x=1791991058;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=X4nUOsQhLXZeWCIVa7oEUi8RfHcyMHhnEr9t9jCy45Y=;
 b=BwuBXdL7ts49DDNODKESD8P3SuvhspBgIOTa/VKBSx8ofeEpk9ecUyXA9XWB9EPbc6
 8oHjfTHwhsa6yVVLf0bxZLDpMUBHtUxzRsvUsohgRPSCxczjOzvCN+UHTnBeo8XGnDzw
 2EXKfq/N78AxYz2PCTH1G0zwgrWYUzJpk2jbG4bkrtazjiwPifjHKTWj8HxLNuS6bYKZ
 xA2Nmu9z1PpfbpSoYNTIvadGtdbuwNsAxgcYfKG/JBPVrcD/CAyOTsOj3eardGAK9q0/
 g2iccGrsq5366tBlIiRn0Mr83LDTT64eonngkHHwwT/FcvGM5p/S3ookeQsVeOYB8SX+
 MUtQ==
X-Gm-Message-State: AFq9FYLj0oNwLVcRbwst/ujZg970CkbJqpwN5JbaTG6d/DM+0dJuKQ4D
 9zYgzhegen9tTitvLrRLXvgujfIt5Hjq1NVNML34rpnyE+q7KsqORYaVxr4Q+HXEWaeyv60xyZA
 ddUWpsd6zc3yruWZdLtx0+1z/+adadIpOUPLHg5dzPeotJtWsday/Cj+y
X-Gm-Gg: AYBFou1U/0bhufFhDnOp/ouEXNCW8XC9M2HWGyNxMUeTRhpSvofvLMdCSc39xLJhJoR
 HLYk4V8V+Nc10VVZS3NppW5LMYqxexZJL9XXH14fHVtQTQSXYLyxVwETKU55/s6O00bedN1MMxk
 j9YyKNEEEsC0Tf3yKbRnRAxQlrDPymEWiZ5l5LGLUHjOZXCkWfObJ6woewVpVVA3yeqv29sNHkb
 qKhV1DhR/Piu3eLfj5uwB/2dG0urHOJf8w8uy/8LjL7GWYQ94o3ex5HzUEFK1TCp0ozV5Z1wjty
 zapxxmK9n8HwhZpiGEMAEAli/qsp8Kp6fCt+SXIT4gKBlissRZaZBuckNBOlQCafi/9b4l01Ajc
 VU6wtz4GbLSmeQTmKaWSAS29cLJ78B9uokN4=
X-Received: by 2002:a05:6000:2311:b0:488:6ed9:b11d with SMTP id
 ffacd0b85a97d-48c728a16dbmr5433608f8f.52.1791386257804; 
 Wed, 07 Oct 2026 08:17:37 -0700 (PDT)
X-Received: by 2002:a05:6000:2311:b0:488:6ed9:b11d with SMTP id
 ffacd0b85a97d-48c728a16dbmr5433559f8f.52.1791386257439; 
 Wed, 07 Oct 2026 08:17:37 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d13a01sm6361117f8f.29.2026.10.07.08.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 08:17:36 -0700 (PDT)
Date: Wed, 7 Oct 2026 17:17:34 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] hw/usb/dev-mtp: Fix heap OOB read in
 usb_mtp_write_metadata()
Message-ID: <asZiSmsX8AAcn60V@leonardi-redhat>
References: <20261007143738.58509-1-tcalifano@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261007143738.58509-1-tcalifano@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 07, 2026 at 04:37:38PM +0200, Tommaso Califano wrote:
>usb_mtp_write_metadata() computed the number of filename characters as
>
>  filename_chars = dlen - offsetof(ObjectInfo, filename)
>
>where dlen is the amount of data copied by the last USB packet of the
>transfer, not the size of the ObjectInfo dataset. If the final packet has
>fewer than 53 bytes, filename_chars underflows to SIZE_MAX, causing
>utf16_to_str() to read far beyond the heap buffer, leaking QEMU host
>process memory.
>
>Use d->length instead: it is the size of the buffer holding the dataset,
>and usb_mtp_write_metadata() is only reached once all d->length bytes
>have been received.
>
>d->length is guest-controlled, so reject datasets too small to hold the
>fixed part of ObjectInfo before dereferencing it. The check is "<="
>rather than "<" because a dataset of exactly offsetof(ObjectInfo,filename)
>bytes would yield an empty filename.
>
>Fixes: 90c1a74271ce ("usb-mtp: Limit filename to object information size")
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3992
>Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
>---

Not a USB expert, but this fix LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks,
Luigi


