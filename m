Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DE4F01821
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySqa-0000ii-T6; Fri, 06 Mar 2026 05:55:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vySqZ-0000iI-Aq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:55:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vySqX-0000LY-Tj
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 05:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772794553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZLk9U3cnn9WXVQRPdQEQwYgcUewFMNjqG4kY0PtkobY=;
 b=BWyaBmiHdc2ybQ2f9Letyztbw6e1nLxWDBn/rSTofKawy/gMj78J0+5IQv7xLlrYlCOANX
 TRMR7XeNKkKTpLvI2IL2Nh32Wjs9JsCtakSJeLQ2Pml/cZsN/cYvSrWfDNN1jYYG03mS+8
 FBa1ivcbSER9SpmPzroxO+91HyuNm+U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-eLYbrbPUMympmDCI49wN-Q-1; Fri, 06 Mar 2026 05:55:51 -0500
X-MC-Unique: eLYbrbPUMympmDCI49wN-Q-1
X-Mimecast-MFC-AGG-ID: eLYbrbPUMympmDCI49wN-Q_1772794551
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439a85832c0so5048740f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 02:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772794551; x=1773399351; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLk9U3cnn9WXVQRPdQEQwYgcUewFMNjqG4kY0PtkobY=;
 b=Ab6S3nJZ34VB8o9E1AQc/dMjCcc0Qx3NMMKqCM/jR67kdJx4ojIeGaj3RaAmbsV+/c
 CclgZ52c+l/IJExZZdg9bAQtjJ1RwmM4yt30DJDk3XkwXe4ideTjRw0SBdBKDsBUe6TS
 UMWlLTZMBTrrfuub8dsX2hee1tcOW0rNpgr80wbkuAq07l9TS+df6IAYQNshpAzL7OvR
 tV5fqdFKx96M40jhje//dERarNN6w6/8rBDD1q+lCh7N8VteGzxV+JQ8T9TmYgX/z6Mx
 4KODeBi/W5HiJCJ0kzShSwNb1wyXEWLa7Ehd+SbT2JqK7m3c2HkbDD0zgMQd5XxtPo9k
 sNkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772794551; x=1773399351;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZLk9U3cnn9WXVQRPdQEQwYgcUewFMNjqG4kY0PtkobY=;
 b=AXTAmI/MpgcqdvwCyOcYlubcWKqH1FLFzxEWxt62qWz/aualQ4JTDaeBPBxbICxFNQ
 zxMG/gb99VCkRCYSOmAdCSJ1Eo9vxW6Vccaxa2dM4LFAz/KfiIZaIBPO4CVVN7aCZ4Ji
 4FVU6ZBYp+hG2Naoope8/hOQq/wnjMorhgYpp4dIqoW46B3ftEhdhIQzpDo2HvvMw6AY
 oHy1X7Em8TOk5BbHz+zQhZoUdsL6JNLlWNnYSGq8DbOgeXjGsnxuXaJN3MKeqJgwUTgi
 9Yaid/4LUj9HMwo5c/AlpXwIwo8O+nUYj0pZ8bSzPf52jZgHPurO0agn+jtK7JdcNE8H
 4rqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBUdkmz/TS/g75xE7/qTIbthGc3wP4eDfR6EI94jxW3rCrJ2S5WXwKhXYyTy7UWq8RZJvymPdUTeZs@nongnu.org
X-Gm-Message-State: AOJu0YyqG96pGv+yo2pl+KS+fGQb7r9S51Ns9usk8BTx3tOqROcPvM4h
 V3/gFUiT3QkrxQe0rua5rD6BttkWaHANyDgUlUiXjsDfCf88/2H0yB6rUcXHZtSydP4uxNFMUzL
 qO9YxZbCl6HAog52yYuSmaTppJz6jlun/DWcOEnIw4CwG87mdtqDnGNRY
X-Gm-Gg: ATEYQzx2n4zdxSUXEWhOWOPVVyR0jm16r5iGk4HQPq7MhCMPhI/0u020A2jk/INWfpr
 DTVwyHY8cn/Sjcn+ykVz7go1NQGIFm5QDormnk+FNRIl4PslgLWTdCz7uYBvo4vRHn6tu782orR
 bLhwewNThF7xYRhg3YQYXYI++LgGVXXW7dH3dcpnx8N4h84Ht5N9WK2Y2NbfvC//f0kdiOKP7ym
 P3Hu8ykRfMyLstdzj575WwlE94CvvtTkHhp9BAUXyLKjw0qNYE0b1JOxF9tYMpYGpsLw7OgxIIP
 QOaN42e9mRT/1czkzmxKmlN4m41qUnN8vlstjQnxV0ZrcyOuDGNrfN5KmWbDKL3M/NsLxUcZMP3
 3PKyzOU7Ca8PRYdOJJkRRF+P8TaxSNrHJik0XAucywRQJkNDLahoLJOOFzYYOk6jnyoII
X-Received: by 2002:a05:6000:612:b0:439:be3e:52fe with SMTP id
 ffacd0b85a97d-439da35cbe7mr2896820f8f.26.1772794550690; 
 Fri, 06 Mar 2026 02:55:50 -0800 (PST)
X-Received: by 2002:a05:6000:612:b0:439:be3e:52fe with SMTP id
 ffacd0b85a97d-439da35cbe7mr2896782f8f.26.1772794550276; 
 Fri, 06 Mar 2026 02:55:50 -0800 (PST)
Received: from rh (p200300f6af4a490003d6f56739ca055c.dip0.t-ipconnect.de.
 [2003:f6:af4a:4900:3d6:f567:39ca:55c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d968sm2789308f8f.6.2026.03.06.02.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 02:55:49 -0800 (PST)
Date: Fri, 6 Mar 2026 11:55:48 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, peterx@redhat.com, 
 philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v8 4/6] target/arm/cpu64: Define cpreg migration tolerance
 for KVM_REG_ARM_VENDOR_HYP_BMAP_2
In-Reply-To: <20260304102249.1963784-5-eric.auger@redhat.com>
Message-ID: <1c804bd6-7a54-53db-15fc-1c7a0865e157@redhat.com>
References: <20260304102249.1963784-1-eric.auger@redhat.com>
 <20260304102249.1963784-5-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, 4 Mar 2026, Eric Auger wrote:
> KVM_REG_ARM_VENDOR_HYP_BMAP_2 pseudo FW register is exposed
> from v6.15 onwards. Backward migration from a >= v6.15 to an older
> kernel would fail without cpreg migration tolerance definition
> for this register.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


