Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC41DC44536
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 14:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viZWE-0007rk-HV; Wed, 21 Jan 2026 09:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1viZVX-0007Dh-Hr
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 09:48:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1viZVV-0004e2-6G
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 09:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769006905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1yEq8agaiClEjvop9wIX9ws+n9IYQVnAS+x1GnNwE0=;
 b=QZxuuCBLkSxvI3uj32FC9wDCBsSaWlb2Qabq4ggBNaaO7o9Q6/itCf7XY9DxvgwmnAgGS4
 ChYN1kH8VNZTSNvCGmkSGX8sQi5LNjU3Ilw/0dvrsUoiyzdl6RSDcvaP1Z7U6tT+fIqhOi
 EtJaJjZ1w1J4snLUarGRIc9UGNh/kqY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-FmwPDO6YMqyJILc_4YUyyg-1; Wed, 21 Jan 2026 09:48:23 -0500
X-MC-Unique: FmwPDO6YMqyJILc_4YUyyg-1
X-Mimecast-MFC-AGG-ID: FmwPDO6YMqyJILc_4YUyyg_1769006903
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-432488a0ce8so5585609f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 06:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769006902; x=1769611702; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=d1yEq8agaiClEjvop9wIX9ws+n9IYQVnAS+x1GnNwE0=;
 b=WccFArJ+TNXIRor0tap1Dht5Wt5trbxxTTyvIqwp0FdktrSKoDFiN8vHbaDToA3cYM
 Ct0JYbEmVRZPQRpSMiHFE8KmnT+qUk+2IMnildbNiIKV2c+pdHKQs0ubkry+ESR21ID7
 x6tfEwWgAwuIsuvJ/bf/Npde2h+7wFtJSksaEQ3+uzvhOSNC3X2Tjh2i/TwCntdr/FfL
 nXJPOXW/ARpcDVDjAzVrlsXYWmCLzLPw3VVx83THlbTDI4CRYv3XU+z8M2/qIf4l3hEi
 BKADKnY5nNA86D7m+QnNx6dJJ1C/WUAs04J5GbYttU5EFHSsYUpxrtQFTF1ILPhzJYKW
 pr1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769006902; x=1769611702;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d1yEq8agaiClEjvop9wIX9ws+n9IYQVnAS+x1GnNwE0=;
 b=YSohK/4z/uy6NMqiTrTaEVPu+Ffl925/jSjU93idVRZjNVMGROEIhlMiN5QjV+8CI/
 oUz5C7gAR9yyufKcJ1QPkCZGo80tUO2rQIZNfkVGcIVowtEhKVVqxdDm66rpeUh7BUKL
 go1fQrAwuIfFmC1U8HF0RtToUJ3b2AJEWeuexMf74ELaSoQblWtanFvnChhakp1uHLCe
 Sb+eOawOIM/UuiOTPs9ci7y7X78y8IA4SIZRxctzD4bv0g+lzCIhhtKo6FejzcxgP0Kw
 pmoY+qKxkhe8wkFYTL3aMmJgfvG1Z4nimP/vYKt0vooMpZK7VA63a5wDW4CT/GijxV6Q
 L52A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOPUwIN4TgRPosM6523Se92SyHv/nwepkXdJn5dHzA8GwSOGUwh3/BB5xCZwXIqZdYyq9hDI5JHbr6@nongnu.org
X-Gm-Message-State: AOJu0Yzww5dgSVbYEX0DhCH1hCjec+dQ2EY5SmH/aprOQlbQwiHY3oDn
 geUVzdyNQTd4b90uiz5gTO2Wi4I3xd4QGo9GI098XRTiyRCyo+TDuNcKvrElh4iDKPY93G/1HQi
 LA//6gc/KbogjVsL3o7glVfPo+WzgipIwW21DxHzkT0L6LqJAs4uw6W+7
X-Gm-Gg: AZuq6aKwZpH/rF1KcS9au5wCDzbGpb265svzzHmkoq5WioOT8LsY11tde3UKG3Yn8NP
 QqrcWIoMwFZNaDxNE9eH35UaHqHxxLSbrvJ9DmG21fh1comQmB+vI9iqczUg60IkcSJEiKlZCSs
 TmCy+Bmw267dEpOa40eGftmVr4quhEqT1kTBGt01Aa6pUBJoeJegBVgwGEXaqHMMAKQPvKnnC5O
 oTqwlC+TofwXMwf1vDM0QA77ANt4B7MWwGiEU9Lha8j7LFd2Rn0g3Nz+STg0PDD7wrnxZ1ZcvWn
 o9iyZ8l48Mq76Aj+jUmlRfpR280DblEz6PPOykG4s8M9KXqMtPdE511CGu1wTcCCi4isyX+NHpu
 wCtKQ+gfzQarfkbOB5jPWQ+mHmDpVLNjLii7+v5paE4NWPfOwyYkxHSb4XS8=
X-Received: by 2002:a05:6000:4210:b0:430:f68f:ee96 with SMTP id
 ffacd0b85a97d-4358ff56807mr9143098f8f.36.1769006902610; 
 Wed, 21 Jan 2026 06:48:22 -0800 (PST)
X-Received: by 2002:a05:6000:4210:b0:430:f68f:ee96 with SMTP id
 ffacd0b85a97d-4358ff56807mr9143051f8f.36.1769006902075; 
 Wed, 21 Jan 2026 06:48:22 -0800 (PST)
Received: from rh (p200300f6af31d00062ddfb9151537832.dip0.t-ipconnect.de.
 [2003:f6:af31:d000:62dd:fb91:5153:7832])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43596b62700sm8490158f8f.42.2026.01.21.06.48.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 06:48:21 -0800 (PST)
Date: Wed, 21 Jan 2026 15:48:20 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v3 1/2] arm: add {get,set}_dczid_bs helpers
In-Reply-To: <20260105154119.59853-2-cohuck@redhat.com>
Message-ID: <6308d1a1-3e26-1eab-6fd6-0f855ae74911@redhat.com>
References: <20260105154119.59853-1-cohuck@redhat.com>
 <20260105154119.59853-2-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 5 Jan 2026, Cornelia Huck wrote:
> Most accesses to cpu->dcz_blocksize really care about
> DCZID_EL0.BS (i.e. the part of the register that does not change at
> different EL.) Wean them off directly dealing with cpu->dcz_blocksize
> so that we can switch to handling DCZID_EL0 differently in a followup
> patch.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


