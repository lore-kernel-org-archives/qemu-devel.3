Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB85C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:50:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visG3-0006Ok-BM; Thu, 22 Jan 2026 05:49:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1visG0-0006KO-Iw
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:49:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1visFz-0003To-5C
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:49:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769078982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jgIPM8OpxHeNCGRc0vlcUybvvkTGH2w92IIDkMB7o/4=;
 b=EqhzdSoQ6sUxpio/6YAntji9VLkPjX0s5navw9CtskpfR/oQFpr21assim0Upmg3jEVbUi
 cgfoBuh8jP9fmVkV8Jl6tb+mNbGPsz2Cxwa0zFqRk3kIJAqXuYkfXl0vTFotddogTXKdrs
 VhDPT6xgXeTK22OceXq6i7MrQvr5v1k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-55BWhaW6Of2bztg3yKhYpw-1; Thu, 22 Jan 2026 05:49:41 -0500
X-MC-Unique: 55BWhaW6Of2bztg3yKhYpw-1
X-Mimecast-MFC-AGG-ID: 55BWhaW6Of2bztg3yKhYpw_1769078980
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43284f60a8aso581974f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 02:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769078980; x=1769683780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jgIPM8OpxHeNCGRc0vlcUybvvkTGH2w92IIDkMB7o/4=;
 b=UaR9DKW623AcQG+L60iO0ZFi1U94mKs80IIrbV5L4/ZSCij8mm1yg5418oSQ3/Bulg
 OcwjzCIduwdL/UYODbkyCMAvlQBdNPx/qO6PJRg63zAU0fOfx6lip4BwJBd7lPRADbfI
 3HMhTTbkKdLjVIH+yqLx34y8U29GI9FYVa5rBC47cCYuq3k7327cnAPMri3nSjfXAMtv
 621bR/C28YF1Pn7sHaRwPxOCJva45wNsfBhYvGmMhltCld1IHZeRUx71vXThxT81dJn3
 ZCpQokz4cpaDeKyE1FI9IiK95/IN2aZrpPOMOfjTOR3mpOHjxp73WZRTTB0b0foEcZoi
 YELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769078980; x=1769683780;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jgIPM8OpxHeNCGRc0vlcUybvvkTGH2w92IIDkMB7o/4=;
 b=NU7fSU0DDaOWxj7gLhvhcDPtNd9ClsuiWQcJjDGOsutxIWzu3RKBiom7Ybwd4QQQ3Q
 H6GdVViW7+bQp1L1UkkNMxucEeQuNk5z2dpsDP76urBeRBwF26vvIIzxWSb1UVq/BDGl
 VCyEu6nAHlczluccjbhzx9OxmkxKLuQtNuueqflN4aoUdRylnGle49uZvfANTT9bG7QY
 pgBy46bVSZmlRRtCktNxY7NWoh9l0qZMpXGov98tz80XW1Z6jbwxaBVv32u7CXbT7r14
 bqH7zM3s4LUx0LnR+E7uBULPUPc3XOyKbjY9/Tst7gHoKokb2FtVTQxnn8v3RaDxkr7t
 ptPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQczb5qNnto4L4544L4nmsBdmRaOWKnaAVbg/Xv+nrURFUnt4zBZ6n8bLdGaUbi0U9wImN9Q8ePf7e@nongnu.org
X-Gm-Message-State: AOJu0Yz8fFi/N93B18wbqu4AwZD4E3iyFqpIJVJfOwZ5Nn9fFpZXx1Se
 wPLb7jwfJ2sPEJWctf6xiqpCdpRbpwaHewJyiSy9EAw9ErqSXt/9JY1BuGr/fFONLHKQKGluplv
 QUd6A9U4uJ4BHgMNbTtePtqId6TdFrnTuoiSdMPSyNcWwXgn0rv2nAtCC
X-Gm-Gg: AZuq6aJEDs267KT9n8s50BTJUpL8qPWhm8ZV0bY8ubHz9H5sHEAVLDbzYxJBKIF3h3B
 dlJFhxTL9eN74kqm+2WmAJj7s5uSYEPh+LICtfyAmtkGEDFvm3qWLiUub6CFe8uWqeSWoABqVnC
 orB/x3PvPOoKNrVFxJwm80P0PjDdTH0PvJacSl7ZTTPANJbVF2BE+PsYy7dfIwIsVMv0rVEtwFO
 sxX5MRkWCFslRA57Uf6/gcw++lgkYb62bwkZhiNHJXBSaYaHPPyx2DOl0kwv3aQfV2332EjQ+W2
 6Rx9ok7tPVe1uLtUUBI9ZiSCbS3+fDL3rYAA3qKZhSyxnLliVQyIg2ZjfMjbwDGmUQa8ucfCr9Y
 BVWxVxJY=
X-Received: by 2002:a05:6000:4021:b0:430:f1e8:ed86 with SMTP id
 ffacd0b85a97d-43569972babmr29574152f8f.4.1769078979813; 
 Thu, 22 Jan 2026 02:49:39 -0800 (PST)
X-Received: by 2002:a05:6000:4021:b0:430:f1e8:ed86 with SMTP id
 ffacd0b85a97d-43569972babmr29574099f8f.4.1769078979369; 
 Thu, 22 Jan 2026 02:49:39 -0800 (PST)
Received: from [192.168.0.9] ([47.64.112.255])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43595609c8asm16397866f8f.34.2026.01.22.02.49.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jan 2026 02:49:38 -0800 (PST)
Message-ID: <05fd4f96-9a91-4459-9166-8af2e5db9539@redhat.com>
Date: Thu, 22 Jan 2026 11:49:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for GSoC internship project ideas
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Helge Deller <deller@gmx.de>, Oliver Steffen <osteffen@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, German Maglione <gmaglione@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alex Bennee <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <CAJSP0QVXXX7GV5W4nj7kP35x_4gbF2nG1G1jdh9Q=XgSx=nX3A@mail.gmail.com>
 <CAMxuvaz8hm1dc6XdsbK99Ng5sOBNxwWg_-UJdBhyptwgUYjcrw@mail.gmail.com>
 <CAJSP0QVQNExn01ipcu4KTQJrmnXGVmvFyKzXe5m9P3_jQwJ6cA@mail.gmail.com>
 <CAJSP0QW4bMO8-iYODO_6oaDn44efPeV6e00AfD5A42pQ9d+REQ@mail.gmail.com>
 <aW_4p65WIEuQO4UQ@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aW_4p65WIEuQO4UQ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 20/01/2026 22.50, Daniel P. Berrangé wrote:
> On Tue, Jan 20, 2026 at 04:42:38PM -0500, Stefan Hajnoczi wrote:
>> Hi Marc-André,
>> I haven't seen discussion about the project ideas you posted, so I'll
>> try to kick it off here for the mkosi idea here.
>>
>> Thomas: Would you like to co-mentor the following project with
>> Marc-André? Also, do you have any concerns about the project idea from
>> the maintainer perspective?
> 
> The idea of being able to build test images is very attractive,
> however, actual deployment of any impl will run into the same
> constraint we've always had. If we host disk images, then we
> have the responsibility to host the complete & corresponding
> source. This is a significant undertaking that we've never been
> wished to take on. IMHO publishing images in GitLab CI won't
> satisfy the license requireemnts.
I agree, and I think if we go ahead with this project, we should not use the 
gitlab-CI to build and provide these images. It would be better to build the 
images on the host that runs "make check", similar to the precaching for 
assets that we currently do. The built images could then be stored in the 
local asset cache so you don't have to rebuild them again the next time your 
run "make check". Does that sound practicable to you?

  Thomas


