Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 629A8C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFBF-0004WM-9B; Tue, 08 Jul 2025 16:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZDg8-0006HP-3b
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:08:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZDg0-0004nY-Ai
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:08:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752001677;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7KHsXJrtbup55Ej/trK6623yLGEmQ02IyXSe57j9ME=;
 b=cgsadX7I+G0om12nEGxAN9RSWHwml/FadpadtCIAxI+zlp5/UsZwd+wJddrY+Py7SU24Da
 /R4ARpII1VcMz4OQwYlXRcma2CF66quQjzMJjcI9gA0KUtp+hsJxN1aKWBmjPeWQwu9K90
 BdADxUk60A9mw/vSiUEKKXrYTSdnoJY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-YFAmshiJP9mxAj7WtpJ_kg-1; Tue, 08 Jul 2025 06:43:42 -0400
X-MC-Unique: YFAmshiJP9mxAj7WtpJ_kg-1
X-Mimecast-MFC-AGG-ID: YFAmshiJP9mxAj7WtpJ_kg_1751971421
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b39cb4ca2eso1637916f8f.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 03:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751971421; x=1752576221;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s7KHsXJrtbup55Ej/trK6623yLGEmQ02IyXSe57j9ME=;
 b=UGM23ieFm7ls/dipeWETMojpA8yecxYprk4a4hq/vCEpM4TG/GCHDTASilOxixrGNg
 eQYMIS5EHkOZmCWVT34T8OTbkzZdogxXPysaNEwUp/LVvha52hl/5dVa9zgEKw9qSFRe
 z3WgZCBPik58izjnIhlCKAqOMx+w6Jr1b+ujw5lQ8TiCo2G4u6jSNmOR1kIZ8useEVop
 cVzpZKlrDjUIPB0+fxT/K0wVeHT4AqOLSuCnMHXRtra3e76oW4fHhi1Q4YW2qjPGXe66
 mpEY5dmardZf3LFqDeUHfYsPGpzZP7sKBZZAs3aT7IFwuAURC0R+rkO0uXw3sEIZyhse
 HUZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsYcnI4N0gdeyX+UOpBUYMBcuJEaiFJoCFfhnzEUf2hWIV0wTdQ9U1pxvPDDDAm3FMXnQC+Pqx6BAt@nongnu.org
X-Gm-Message-State: AOJu0YycrS9qWF5ARcCgCjbkdsx5ghH7ui6h7KKXV8GnEEJ2ExtXuO7n
 nKJYcEzqijDymfyEXXLYHOB5zGVPzKad0tg7pH2iJ57LguE+6MmnVYTDZj3nxTimDsaX95t8Dfl
 4fnCeobHVBqfHUq4AXaOrCOdg0i2tEmhRDEQAaYXy9wqRfrDqAFemjfPr
X-Gm-Gg: ASbGncs9ORQtSA9Ryl6lYbs2jBHHz7BA3T93lnbn1LHYqOFMTM8t+43rdm7b3yT+lkx
 T6AN5SHEmB+c8MLRC0cAUrYqSLPYl9VF0+e8Oc0ZjotTPS/ncVALqAtc+B0pKYZuNYir7aE6llY
 G3PXlMHN+sMb/h1MLbM4Qlmv+ELD04tXXYOwF1ALC9vU2TaihnkNh4Cfvzi+pkQOboWaGGFCRHs
 oiq+qKD1TlXPIuQ3dxReNVf6KwdCqYvs6GIbxA+1dAhCqfCam6bBjiGZHJqv/b/aDaKhWWxvREn
 6XQPICOBYj7zz5bHkjfmna0EoDGckAcDOjX9RgYBwjreHlkqTv0jYcqIBKNI6YzPAW/G6A==
X-Received: by 2002:a5d:5f55:0:b0:3a4:f52d:8b05 with SMTP id
 ffacd0b85a97d-3b4964df03fmr15413644f8f.35.1751971421113; 
 Tue, 08 Jul 2025 03:43:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8JvXxldYpwpXsSioxikdestTUNuNGRs5+UWJq5KdWk2eaCp6dsNnyD1SXHPtXHIH4bc6GLQ==
X-Received: by 2002:a5d:5f55:0:b0:3a4:f52d:8b05 with SMTP id
 ffacd0b85a97d-3b4964df03fmr15413623f8f.35.1751971420646; 
 Tue, 08 Jul 2025 03:43:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd45b8a2sm18420575e9.18.2025.07.08.03.43.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 03:43:39 -0700 (PDT)
Message-ID: <23c5ce54-f4a2-4429-876b-b67cb488bfb4@redhat.com>
Date: Tue, 8 Jul 2025 12:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/36] qtest/bios-tables-test: Generate DSDT.viot
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, imammedo@redhat.com, gustavo.romero@linaro.org,
 anisinha@redhat.com, mst@redhat.com, shannon.zhaosl@gmail.com,
 pbonzini@redhat.com, philmd@linaro.org, alex.bennee@linaro.org
References: <20250703123728.414386-1-eric.auger@redhat.com>
 <20250703123728.414386-20-eric.auger@redhat.com>
 <20250703155221.00004c71@huawei.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250703155221.00004c71@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jonathan,

On 7/3/25 4:52 PM, Jonathan Cameron wrote:
> On Thu,  3 Jul 2025 14:35:19 +0200
> Eric Auger <eric.auger@redhat.com> wrote:
>
>> Use a specific DSDT.viot reference blob instead of relying on
>> the default DSDT blob. The context has not changed.
I meant s/context/content
> So this is the same as the default until the next patch?
yes that's correct.
> Maybe should introduce the file only then instead.
>
> Not important though given how short a time this lasts
> for.
bah yes I thought it made sense to introduce this intermediate state. If
you don't mind I will keep as is.

Thanks!

Eric
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>
>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>>  tests/data/acpi/aarch64/virt/DSDT.viot      | Bin 0 -> 5158 bytes
>>  2 files changed, 1 deletion(-)
>>
>> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
>> index 7a74beab3d..dfb8523c8b 100644
>> --- a/tests/qtest/bios-tables-test-allowed-diff.h
>> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
>> @@ -1,2 +1 @@
>>  /* List of comma-separated changed AML files to ignore */
>> -"tests/data/acpi/aarch64/virt/DSDT.viot",
>> diff --git a/tests/data/acpi/aarch64/virt/DSDT.viot b/tests/data/acpi/aarch64/virt/DSDT.viot
>> index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..acab6e65febbc210158d4c39be0680bbb90250f5 100644
>> GIT binary patch
>> literal 5158
>> zcmZvg%WoT16o=2)6MH;<Wc*0%I8N+Bsd!dnyJ^zWmfB+{aj_HQNgE_rawJql$)*w&
>> zQmK&AELzBpMq(YL{vk-LkXW!|(KQ?X0d^SOc{t~%o>|y)ALqOG8=sMmZ^!NIT`CYo
>> z{%G$y+itD>`OvA=YBi0B)V=z)p54~&Pu%uod|Y;H+cqZKy-vF2412b1uahyk+w0Ky
>> z_`0(@2**Z)ZQHKbgE3>`jNEM5EIv<=0w%~J`Y}eDc7ceV(D-;`bKlwYxu10hcWv8l  
>> zkTG%hT4vIiI8ICR5m__iBO-}X5ZTi2jlwPUcSgImZLgg#JBvJD+@wgbxXlrDe|1Et
>> zW#2$V7@{5^+G-aK31LPghRzrb&S;8^sKkgdMw2tHhzwm~7>sd+GuA}LoWw90V~sPe
>> zij0`VNHNA$&R7>2afy*(jCIb~5E+KVuoz>5Gp>n@gv7`(#x=&M2QLSvm}yFk0%Kg~  
>> z3^7gdB?(h~kug5z3^`9z(mqOzaf37DJWWfCGGpB23^`9T5~IQxw>U%2(|L)p${3$;  
>> zhMcFC#HcaGZO)MMG%GRQVvH7N$a$KR7#A6%%^7l@<|W1@#&8&;A?Im9V!X>39nO&R
>> zbU|Xg&lp|Kkn?m=VtmLLo17u%X;ETaW{fS)kn^-8F>J=z<_tMcmn24mF?yUK=V@7D
>> zTw#nmoFV7wvc$N`7@u;6oTn9uvB4O9&XDtTMPgiMi~(ab<vd-L7&jPWhco0ntxAkr
>> zjIkRqdU}6W5Dj;RwqtM3ijU#Q&1TG`SLeL#&G(BK>?_13?#R`~J}TG_pfm$e7X_5x  
>> zH$&Y~y9(YOK&fJcZ|fa_<@X^gc#Dt~Mb;&O<@cSlUJjjJ@T)0S%id7Wq}K^rO;z)C
>> zx5${Z+dH%8=<bcORkJcAhkEpYYGhN5I`n|PrHAwdJs?sLuS^?`_VWF2%%faVPfn+#
>> zejD=dwZ3iFDVI|HW<))nuo3Osc9U{xJvE(bq+;r`mWpanF5{1Ran19linN2d5ihba
>> zYpKX^YQ&GUgUASZk>M&)FEZRg)Qb$KM*YZo5E=C&!&P)IGTedgMTS##KQi3B?nj2J
>> z%z@_|c+R2coF5sk5(Cc|c*f8(hMsZojDu$!J>%$UfTsbT26`IknE=lOcqY&@fu1IK  
>> zn&4@or-`0P@Jxbd5<QdXnF7xgc&5-Zg`R2fOoL|{J=5r!0nZG0X3#T(p7Y>251#Yr
>> zIgg$ecv|3Tp{IqOS@6t)XBIuP=$Ql09C+r?Gl!me@XUi}9zFBuSpd%hcoxvJfSwEB
>> zxd5IE=(&KNi{QBko{Q+Yh@M68EP`hdJ&WjB0?!h7me8|=o=f1l1fEOixrCl&@GOI8
>> z89mGBxeT7m;JJ*R%jj7F&kA@}(6fS`E8w{To-63Nf}X43xeA`E=(&oXRq(8WXB9oG
>> zp=ZIGIPDg_%BWKx_5a4NShnNl;~&x#Ns+py>O*@`Buc5n9CcaK>3`~PnHs(PqDWdQ  
>> z>bHod-t_4$B8^TyU@_ix<jt7+lh~#DpHQJ6pX|DhesV}oXTN^7Gk5w`Hg8(v!RzL~  
>> z)ynOk_aC=@z4_OdCx@o)boLu3ho<3l_M4B?$HCJBvwCo5y*z!WeXqj3vHDs5<*7I9
>> z_gQM>(ShpuCFOT1RQ=Uq;iE~%9q4Bl{5Ahv|NU=w?YqHG#eW7%zd3`m#Oc@cDjU@_  
>> z^+Ds~fj;WGthjN!BP@0B)imul%)O^OoldLjDYMH`_v%Ef9lw8Bow;pwI}`ux!9Q@T
>> zt0L)cuan;DcA%h)YVY}>N8M3(i&8{J!qmsllB(%+-EO~DSebP1?Ij+m#=)6&`t-n5  
>> ZwaN40{-|vpjgObqjlY;*>N!CX_CM8!>@ENR
>>
>> literal 0
>> HcmV?d00001
>>


