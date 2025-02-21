Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 888A8C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 15:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlVA8-0000tS-H6; Fri, 21 Feb 2025 10:42:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlVA4-0000pU-9A
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tlV9y-0002PX-On
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 10:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740152507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=D8gcfSW++PlYBcLfNdKaTqKSoUwp2J2p+vdlSr+cwe8=;
 b=APTeqZr+kMuMDYyZKq4APQX6xBBYDY+X683YtF+oPNfWIy24bJD5fkM2ViA9s0XTF1kjZ+
 5P7VIGFgx36RxLLjFu97ID8ppC8N6lJJ/yqzBCFY2+h/F0M9fzmK0qMLZYEyM4/O7ogLoF
 ViLkL+ZqwM8RH1RV7jJqn3bna++yoSQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-UQF2TdCfPV6Ha9SeggUOfA-1; Fri, 21 Feb 2025 10:41:44 -0500
X-MC-Unique: UQF2TdCfPV6Ha9SeggUOfA-1
X-Mimecast-MFC-AGG-ID: UQF2TdCfPV6Ha9SeggUOfA_1740152504
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f4e6e004fso1604550f8f.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 07:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740152503; x=1740757303;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D8gcfSW++PlYBcLfNdKaTqKSoUwp2J2p+vdlSr+cwe8=;
 b=FaXwJ6/yQbvrWbVr4xnXnkgoFriAm71aJTx6t6kzmhcZ92/8MXyNvGzpEtfRRFAkwx
 sd4oC1qdSu60R57RudTE2O2UpdgsEK5wnaDTH0tj/MAZI3NF7MpQhmFqqhZg0X/vVqmC
 VwzZuJB5kJplXUYoJ2ZjgZhZDDZMPU296PRwD0k9NCEMh9BSXMtHfRHcAjelXVPR4pw4
 oq8ptprIyL6FKXLfldNqUWprnIE2WCUbe5BpeztvHT807DjB+81wiWeXTX+Sp7QWdiqQ
 JZb/ODv0piGso44R/K/juBCeL/3/TKx78g3AUKZdAp33s3jqQfjINhiKiNPJeznrQZk7
 O6VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkBqBai+Q1CTPNUw2uAKm3QjvkEkwXEK0jz2NHz0qxgPQjdM0808AbFVca675pXnMZaAkYkfCSBWVr@nongnu.org
X-Gm-Message-State: AOJu0YzZuBO+fRg8SSw0bDAyAMbUJ7llv6lYZvtJI1TfuNzCZWGqvLF5
 Kkj4FgE/Mjs/qTkDhShhDM8Cr60JXQKuKh6Qak2S+hxPKth3bmp3i61ZSIPI19UnMOaGm5Hx41J
 BKT5ttdYBWzJSzHnNMcYFMuGDfz9cod2VMkzfpO+okYeD1wBHO/Zxfgt8klZ4vN8=
X-Gm-Gg: ASbGncuwJCSdfEckEU3Z9PvJC8yq4yTqNYjRLN/7jc5ED2XPfORNmMsWFm+B9BFSjAx
 IKA1LyjQNoJj7iKCLI+UWGXQF6uO1r+LsYphSqzl47/30LclkMOwOkqkSFqkRHcJdKQhcpLEp1o
 Q1mLLDeBOmmN6mK8V/U8++mpwo3OZYLsiqu6weqoj7VKrKqI8qtE7H2+620IF1kZqG5eNLxrsbm
 nZ3IyQ5co/BQCPGx7fJRwifGXpJqcBiAVYBeWlbol0KNp2ldqVYJ4/S5fYxe/jS8BUKZqO8/gNz
 8pBPe4JYqx26gdY4EpU=
X-Received: by 2002:a05:6000:1889:b0:38d:c627:f634 with SMTP id
 ffacd0b85a97d-38f6f0bf363mr3412155f8f.50.1740152503260; 
 Fri, 21 Feb 2025 07:41:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlKbjqBZq9U2vth3lPOrdwr4vsBQVusiXUAMNqXM0U0bOXCeJ7pCAILzs3fZEsSh9jViGuUA==
X-Received: by 2002:a05:6000:1889:b0:38d:c627:f634 with SMTP id
 ffacd0b85a97d-38f6f0bf363mr3412133f8f.50.1740152502908; 
 Fri, 21 Feb 2025 07:41:42 -0800 (PST)
Received: from [192.168.10.81] ([151.95.61.185])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8217sm24029281f8f.90.2025.02.21.07.41.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Feb 2025 07:41:42 -0800 (PST)
Message-ID: <21c3c655-3676-4bd3-9088-8f266d5dfd3a@redhat.com>
Date: Fri, 21 Feb 2025 16:41:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 122/162] tcg: Add tcg_gen_addcio_{i32,i64,tl}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-123-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <20250216231012.2808572-123-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Ok, this one definitely caught my eye. :)

On 2/17/25 00:09, Richard Henderson wrote:
> +        tcg_gen_add_i32(t0, a, b);
> +        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, a);

Compare against b instead?  If there's an immediate (which could even be
zero) it is there.

> +        tcg_gen_add_i32(r, t0, ci);
> +        tcg_gen_setcond_i32(TCG_COND_LTU, t0, r, t0);
> +        tcg_gen_or_i32(co, t0, t1);

setcond + or can become a movcond:

         /* co = t1 | (r < t0) */
         tcg_gen_movcond_i32(TCG_COND_LTU, co, r, t0, tcg_constant_i32(1), t1);

> +            TCGv_i64 t0 = tcg_temp_ebb_new_i64();
> +            TCGv_i64 t1 = tcg_temp_ebb_new_i64();
> +
> +            tcg_gen_add_i64(t0, a, b);
> +            tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, a);
> +            tcg_gen_add_i64(r, t0, ci);
> +            tcg_gen_setcond_i64(TCG_COND_LTU, t0, r, t0);
> +            tcg_gen_or_i64(co, t0, t1);

The same two observations as above apply here, of course.

> +            tcg_temp_free_i64(t0);
> +            tcg_temp_free_i64(t1);
> +        }
> +    } else {
> +        if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
> +            TCGv_i32 discard = tcg_temp_ebb_new_i32();
> +            TCGv_i32 zero = tcg_constant_i32(0);
> +            TCGv_i32 mone = tcg_constant_i32(-1);
> +
> +            tcg_gen_op3_i32(INDEX_op_addco, discard, TCGV_LOW(ci), mone);
> +            tcg_gen_op3_i32(INDEX_op_addcio, discard, TCGV_HIGH(ci), mone);

This addcio is unnecessary/incorrect.  I think you assume that TCGV_HIGH(ci) = 0,
since that's what you set it below, and then this you can remove it.

But if you really wanted to do it, it should go...

> +            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_LOW(r),
> +                            TCGV_LOW(a), TCGV_LOW(b));

... here, after the low word is all set, to "OR" the input high-carry into the
output low-carry.  But again, I think it's not necessary.

> +            tcg_gen_op3_i32(INDEX_op_addcio, TCGV_HIGH(r),
> +                            TCGV_HIGH(a), TCGV_HIGH(b));
> +            tcg_gen_op3_i32(INDEX_op_addci, TCGV_LOW(co), zero, zero);
> +            tcg_temp_free_i32(discard);
> +        } else {
> +            TCGv_i32 t0 = tcg_temp_ebb_new_i32();
> +            TCGv_i32 c0 = tcg_temp_ebb_new_i32();
> +            TCGv_i32 c1 = tcg_temp_ebb_new_i32();
> +
> +            tcg_gen_or_i32(c1, TCGV_LOW(ci), TCGV_HIGH(ci));
> +            tcg_gen_setcondi_i32(TCG_COND_NE, c1, c1, 0);

Likewise, this shouldn't be needed and you can just add TCGV_LOW(ci)
below.

> +            tcg_gen_add_i32(t0, TCGV_LOW(a), TCGV_LOW(b));
> +            tcg_gen_setcond_i32(TCG_COND_LTU, c0, t0, TCGV_LOW(a));

Here you can also change a to b.

> +            tcg_gen_add_i32(TCGV_LOW(r), t0, c1);
> +            tcg_gen_setcond_i32(TCG_COND_LTU, c1, TCGV_LOW(r), c1);
> +            tcg_gen_or_i32(c1, c1, c0);

             /* c1 = c0 | (r < ci) */
             tcg_gen_movcond_i32(TCG_COND_LTU, c1, TCGV_LOW(r), TCGV_LOW(ci), tcg_constant_i32(1), c0);

> +            tcg_gen_add_i32(t0, TCGV_HIGH(a), TCGV_HIGH(b));
> +            tcg_gen_setcond_i32(TCG_COND_LTU, c0, t0, TCGV_HIGH(a));

Change a to b.

> +            tcg_gen_add_i32(TCGV_HIGH(r), t0, c1);
> +            tcg_gen_setcond_i32(TCG_COND_LTU, c1, TCGV_HIGH(r), c1);
> +            tcg_gen_or_i32(TCGV_LOW(co), c0, c1);

+            /* c1 = c0 | (r < c1) */
+            tcg_gen_movcond_i32(TCG_COND_LTU, c1, TCGV_HIGH(r), c1, tcg_constant_i32(1), c0);

> +            tcg_temp_free_i32(t0);
> +            tcg_temp_free_i32(c0);
> +            tcg_temp_free_i32(c1);
> +        }
> +        tcg_gen_movi_i32(TCGV_HIGH(co), 0);
> +    }
> +}
> +
>   void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
>                         TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
>   {


