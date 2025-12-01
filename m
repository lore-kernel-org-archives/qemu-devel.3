Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D60D116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 21:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQBnk-0003qy-AO; Mon, 01 Dec 2025 16:51:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQBnZ-0003l9-Tt
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 16:51:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vQBnY-0006aE-5t
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 16:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764625865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=snll9VX+f1i7V5LAz2XVXRC2qfXV76TLACxDG4VlZWA=;
 b=Ih+z0QcgwtSuYE1sPty0Lp4vrQJ0ZDOCt5xI9uJvWJIbJClLIghJa55MRh2MGuHJQqPoRb
 I4xBZrc7aGGvV1NRd1QUHfVKRLSwhhOHRqyjVGv3OmywLgGIOkRULLQtB7cXXXGwLeCbmh
 he2QpKWgW4h1iCDaoUUpZx/C6nTE/Tk=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-SELpKsntPNqzCctftJoZiQ-1; Mon, 01 Dec 2025 16:51:03 -0500
X-MC-Unique: SELpKsntPNqzCctftJoZiQ-1
X-Mimecast-MFC-AGG-ID: SELpKsntPNqzCctftJoZiQ_1764625863
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4ee0488e746so78226931cf.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 13:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764625863; x=1765230663; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=snll9VX+f1i7V5LAz2XVXRC2qfXV76TLACxDG4VlZWA=;
 b=uL922sDwUnPp6vc760lIwO8P46CAI3hcN9Z+A9WrOSw05Mrd1gXqAHJL/6uzHvomPD
 OEfjLDTV0gdyu34ieooqbaaowAD/EFAFZceO4V0nNdyY/f8J+NtpgsDls487w/OWCMVP
 y8P0SF/fcLIFl6h27QR9rJ1AFlw67CqttP4k3uJMhkOkKdJoDpEc0p6i831chfwehA6i
 FUTBSUUbWmVgxpKXYURoZP602pgaZtbZKLoxx0gAwiP1bouJK8iE0O5+XC0kGn9eyxbC
 Eq6Zvw76YY5cSGmKtwVye0g05AUOkQj0eluuxipEitKkH8JrK/UhSWzAiz2wWP7KfNGo
 bQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764625863; x=1765230663;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=snll9VX+f1i7V5LAz2XVXRC2qfXV76TLACxDG4VlZWA=;
 b=im1VDkk3+fRhvUuMKZWab+MiGS8FXET94c0hDZpbd6w9d11i6oU99wmuGqzPf8unFl
 evdp7YsH+ktsHTu0EVEn+5QkOClbjEmPg5kEZqJqdXOthzJRCr/R644GYt1v6KMWTWAX
 iS/B/MCp/i45GCrKpX14lHDny/4Y2lK1CB2VlcUYBPnfaj/KWA6QPuRekpp+FC8ubNrv
 sUeMYEBSpjyQnKrzY7zrSKctAR5b8nSPABdXR1eKscJ1lW/UGAi3tqoQ+Qo+jhmO4aHn
 YxnZUAfww8vQApDC8uAGOEATdDMAX0FGmaHCxNuMWeDyuAFFdeULFUomcSy+YfSl2tq6
 rgbg==
X-Gm-Message-State: AOJu0Yy7zCgudn+yTXwqs3KriWcGvYL7PU6iMTx1NrJY/D75QHutPpAX
 Gf4/xL0ONmk/YWzSRmnppdPECPvLbHx0hnM0MGS2Q899vDTnhlDfKwTFn7sG81akW+Dm73dZJSY
 RHPUq6UDDxXMIz/3MtAUu0tZb1otwKaO2ilp2Qo3rcCinoVoQCg+nAst1
X-Gm-Gg: ASbGncugDmECaU6np3ZJqNbE5Cex6hK0xk5CfT9rSkNORagaIc/0jfKPoYnhd/LMrdI
 0/VSTHigIYElrKoMMMWaYWmig9vy8by0vSTpsM2ER+FKZXxWGaaFuW6g32QgvwUJYyCq5C4ogeX
 zZuqsArtfnq2XS4F24FG7bogvlj1KTE3NlRbk8O4ZmiGC4DBpd9UpLH2RfxF/6+Ov7dIBy0Nr/9
 HTCpXU9x+Z1qLOHjgGNm8pUEqn9hdxRLsmUgT4UV0IMsZX5JOdzL4vDn76vTB+JpIDeBuRENbd7
 iAozCZNY/4ZT8WxJauy5PH3zlTXT3EktXv1C1OTbghYaXtcLloIXjM3onNhj92kBSz0XTwHc1B2
 hZrY=
X-Received: by 2002:a05:622a:1a1e:b0:4ed:ba4c:bda8 with SMTP id
 d75a77b69052e-4f00894e9a6mr1237041cf.18.1764625863034; 
 Mon, 01 Dec 2025 13:51:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGy+LeOszV0f4BWfnG2CjYb0wgzlAgbwyWbgvhQkRcyCBfVNdRJyG9Snr3M0MAjjmlAUcLfow==
X-Received: by 2002:a05:622a:1a1e:b0:4ed:ba4c:bda8 with SMTP id
 d75a77b69052e-4f00894e9a6mr1236701cf.18.1764625862566; 
 Mon, 01 Dec 2025 13:51:02 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4efd2f9a3b5sm82617371cf.1.2025.12.01.13.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 13:51:02 -0800 (PST)
Date: Mon, 1 Dec 2025 16:51:01 -0500
From: Peter Xu <peterx@redhat.com>
To: Pawel Zmarzly <pzmarzly0@gmail.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, michel@michel-slm.name
Subject: Re: [PATCH] scripts/analyze-migration: Rename RAM_SAVE_FLAG_COMPRESS
 to RAM_SAVE_FLAG_ZERO
Message-ID: <aS4NxQ3MxEmY5Ryx@x1.local>
References: <20251125173007.245607-1-pzmarzly0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251125173007.245607-1-pzmarzly0@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Nov 25, 2025 at 05:30:07PM +0000, Pawel Zmarzly wrote:
> It has been renamed on the C side a few years ago. In modern QEMU versions,
> fill_byte must be zero. Updating the Python script to make grepping and
> understanding the code easier.
> 
> Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
> ---
>  scripts/analyze-migration.py | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> index 67631ac43e..6364fe4f72 100755
> --- a/scripts/analyze-migration.py
> +++ b/scripts/analyze-migration.py
> @@ -107,7 +107,7 @@ def close(self):
>          self.file.close()
>  
>  class RamSection(object):
> -    RAM_SAVE_FLAG_COMPRESS = 0x02
> +    RAM_SAVE_FLAG_ZERO     = 0x02
>      RAM_SAVE_FLAG_MEM_SIZE = 0x04
>      RAM_SAVE_FLAG_PAGE     = 0x08
>      RAM_SAVE_FLAG_EOS      = 0x10
> @@ -172,19 +172,15 @@ def read(self):
>                          mr_addr = self.file.read64()
>                  flags &= ~self.RAM_SAVE_FLAG_MEM_SIZE
>  
> -            if flags & self.RAM_SAVE_FLAG_COMPRESS:
> +            if flags & self.RAM_SAVE_FLAG_ZERO:
>                  if flags & self.RAM_SAVE_FLAG_CONTINUE:
>                      flags &= ~self.RAM_SAVE_FLAG_CONTINUE
>                  else:
>                      self.name = self.file.readstr()
> -                fill_char = self.file.read8()
> -                # The page in question is filled with fill_char now
> -                if self.write_memory and fill_char != 0:
> -                    self.files[self.name].seek(addr, os.SEEK_SET)
> -                    self.files[self.name].write(chr(fill_char) * self.TARGET_PAGE_SIZE)
> +                _fill_char = self.file.read8()

We can sanity check this is zero.  But it's fine; no big deal.

Queued, thanks.

>                  if self.dump_memory:
> -                    self.memory['%s (0x%016x)' % (self.name, addr)] = 'Filled with 0x%02x' % fill_char
> -                flags &= ~self.RAM_SAVE_FLAG_COMPRESS
> +                    self.memory['%s (0x%016x)' % (self.name, addr)] = 'Filled with 0x00'
> +                flags &= ~self.RAM_SAVE_FLAG_ZERO
>              elif flags & self.RAM_SAVE_FLAG_PAGE:
>                  if flags & self.RAM_SAVE_FLAG_CONTINUE:
>                      flags &= ~self.RAM_SAVE_FLAG_CONTINUE
> -- 
> 2.52.0
> 

-- 
Peter Xu


