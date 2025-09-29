Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E748CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ETD-0006PS-2o; Mon, 29 Sep 2025 10:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1v3ET8-0006Ny-H5
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:03:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1v3ESr-0008So-Up
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759154560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rQmi03nc1p7rXfmPkR24IE0tp5eJRTF6oVF3saBmk0Q=;
 b=ApKVKuOcdplgL8DGeACAtfay022X6XC//7FAqCoSY6qwInxXJGBB0JKnde8fGJDY/4T1Oz
 UErf+J1Y6YAu5gw6dpHeIXtJWCnHU0ElRAhOdf27o0SCklQkSF7NeY0FhdDSxCsEEs+U/c
 KCFnE6XlTzpQSl/rlmC67QBGsL94kwM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-WI9m3Om7Po2zjqw5k-omWw-1; Mon, 29 Sep 2025 10:02:38 -0400
X-MC-Unique: WI9m3Om7Po2zjqw5k-omWw-1
X-Mimecast-MFC-AGG-ID: WI9m3Om7Po2zjqw5k-omWw_1759154557
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee13baf21dso3795226f8f.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 07:02:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759154557; x=1759759357;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rQmi03nc1p7rXfmPkR24IE0tp5eJRTF6oVF3saBmk0Q=;
 b=tVnAzrfeptpizSvn0B2r5PAzb2J4arZ5iO4fryMdPFFlWKlwjM6R4jDif/q3ZXZQoV
 wpVGrEoUAeEX2F0KAIUjrwmDo4qHbkr7fDsQDsw+CnIO3WzAyQrvYPDIF0oUJxFVSR8N
 7vg8QZz22S6Lo+PsqhwvkXdAk5Y+NJRUu9aFRahPovflMAeMzPZXZ1B75qZNcZDHn2wl
 I5a7nOTd6HybH4i3cle8b3R8VZFo8OvyrCaJ0JhpUG/vUH43i6Yc5u7RPkmoEgES6z68
 ehhzSbr77QC5p57Rl7DzZ+6Cesd2i2SvyDpKmFYgInBEzWIz/H8JvkHO8fDZH7/1PU2A
 +vOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTKGU9U1tLr3PqgKpGa/1ifX/ug7z9KT1mdra8I/6cTUiTd7+NvxZhpDCe2puSa+Q7Kv5E2gHCZtS7@nongnu.org
X-Gm-Message-State: AOJu0YwbuUcbzZePyMow75Zupr2YM1sH8QCELrifdmXDX/uzc3LbPsWC
 93QMunJxXwV1EniDuD/32kx4SealG7SKxVRN2uoLJnzUEjw+djkjeLXh4XR13DIaXEOuZ17eksk
 m9wljsPBHD9RMhuyhV6jYrB3+9t4z0s6gtx7oeJNDbKGy5IYxr1Dt/Jyi
X-Gm-Gg: ASbGnctzGOaRgWhoU0ip5skK4D88vTjD3CaatzSKwhD77sH+LL5ee7T8b1W6oxOO8Dy
 JhC+XT72AZoNCxcruvOmHZwdgQ7zxN9NxYbRAn1BejSGkabpf+Sx76J5MAch/PISHLJEmFumP5m
 lbIzj7urm/Std2ssPPPTuO0m4x9Kus7itSaam3jnd5ILCWNQS7e7dHDGBNhFjQ+WEOk6u0oUSb7
 xCvHi8wNnQ8WfvWKi8M1addicUc8/w8z9vHP7ddaZFZ3vpd1i+343Oygdbcht90fxiHQFmGdyRu
 zg/vfrBe2gYMf/0cts2wzvfDGMezYpoOnSgXANuKpOJTihDgyoOekT/uzP0/QHopubaq/MXUYo8
 uy2haxYO/2HgMy0nbh0Av9TC3lUhHakk4L++Vvb/CQRWwpprd3I82IdldGd+h6Uy9LynP
X-Received: by 2002:a05:6000:2dc9:b0:3ec:ce37:3a6a with SMTP id
 ffacd0b85a97d-40e4458ce65mr15636959f8f.22.1759154556901; 
 Mon, 29 Sep 2025 07:02:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdcbthOWlHFvz8nFBuYbxBo37MgTRCOv0g7ugnf2GaFdCgqp11oYtCAiUh9vpPiOfTy4kreA==
X-Received: by 2002:a05:6000:2dc9:b0:3ec:ce37:3a6a with SMTP id
 ffacd0b85a97d-40e4458ce65mr15636924f8f.22.1759154556449; 
 Mon, 29 Sep 2025 07:02:36 -0700 (PDT)
Received: from ?IPV6:2003:cf:d721:7591:49e3:7f03:39f3:2df3?
 (p200300cfd721759149e37f0339f32df3.dip0.t-ipconnect.de.
 [2003:cf:d721:7591:49e3:7f03:39f3:2df3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e42eee0b6sm117195635e9.10.2025.09.29.07.02.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 07:02:35 -0700 (PDT)
Message-ID: <cb615e7a-412f-469d-9fee-1f8621cc6aad@redhat.com>
Date: Mon, 29 Sep 2025 16:02:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] block: Expose block limits in monitor and qemu-img
 info
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org
References: <20250923163735.378254-1-kwolf@redhat.com>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20250923163735.378254-1-kwolf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 23.09.25 18:37, Kevin Wolf wrote:
> This information can be useful both for debugging and for management
> tools trying to configure guest devices with the optimal limits
> (possibly across multiple hosts). There is no reason not to make it
> available, so just add it both in the monitor (QMP and HMP) and in
> 'qemu-img info'.
>
> Kevin Wolf (2):
>    block: Expose block limits for images in QMP
>    qemu-img info: Optionally show block limits

With or without the comment changes to patch 1:

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>

(And I vote for keeping the paranthesized text in patch 2.)


