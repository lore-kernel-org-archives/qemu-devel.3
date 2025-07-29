Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12A7C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 08:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugfeP-0007i2-FS; Tue, 29 Jul 2025 04:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ugfe7-0007UU-9s; Tue, 29 Jul 2025 04:25:15 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1ugfe3-0004FG-Pe; Tue, 29 Jul 2025 04:25:14 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 56T8OdTg090393
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 29 Jul 2025 17:24:39 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=CTZXgwwA5ksGGuV2OCgzO7qcQuGI2jm78q+NM7dxC8U=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1753777479; v=1;
 b=eugZcaHw/xL+aFOsAkfCbx2+CX8MyQUaR/kytHJTZuMfAcK5r48VyavHlGdE1MDl
 mJAmkOnHhVYSsVYHGZhw1/MKmRXjnMYSQbNmUcuxFxbIHdTyJaxXAH+8K0DPYMc6
 6o7XxxWONnk4bcyEPHZxXBHdD1w1rf2nldgDuyhAbsjaURFpdjB2nDWDWlvK2pcW
 1MR3nfFOs8gpSRB/660m3b9PzieP5bgsSti0lWcnTrxzdaaiSVeUdo0RA6uJjbhU
 b35S2vKBFkmiprryvd70RZN7nafiGW4ysP8IJpRHh0diOqKI+ZX+1LT/EPUVoWZS
 Cdn6cfv1ZRflxpE/e5aI8w==
Message-ID: <1ff92294-5c8c-4b33-89c1-91d37d6accb0@rsg.ci.i.u-tokyo.ac.jp>
Date: Tue, 29 Jul 2025 17:24:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 23/24] migration: Add error-parameterized function
 variants in VMSD struct
To: armenon@redhat.com
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20250725-propagate_tpm_error-v7-0-d52704443975@redhat.com>
 <20250725-propagate_tpm_error-v7-23-d52704443975@redhat.com>
 <848e0e7e-2ad5-4d94-99eb-8314540ea0de@rsg.ci.i.u-tokyo.ac.jp>
 <aIdW8xBboyQZZYnf@armenon-kvm.bengluru.csb>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <aIdW8xBboyQZZYnf@armenon-kvm.bengluru.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/07/28 19:54, Arun Menon wrote:
>>
>>> +                            error_free_or_abort(errp);
>>> +                            error_propagate(errp, local_err);
>>> +                            ret = ps_ret;
>>> +                        }
>>> +                    } else if (vmsd->post_save) {
>>> +                        int ps_ret = vmsd->post_save(opaque);
>>> +                        if (ps_ret < 0) {
>>> +                            ret = ps_ret;
>>> +                        }
>>>                        }
>>>                        return ret;
>>>                    }
>>> @@ -554,7 +590,17 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
>>>        ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
>>> -    if (vmsd->post_save) {
>>> +    if (vmsd->post_save_errp) {
>>> +        int ps_ret = vmsd->post_save_errp(opaque, &local_err);
>>> +        if (!ret && ps_ret) {
>>> +            ret = ps_ret;
>>> +            error_propagate(errp, local_err);
>>> +        } else if (ret && ps_ret) {
>>> +            error_free_or_abort(errp);
>>> +            error_propagate(errp, local_err);
>>> +            ret = ps_ret;
>>> +        }
>>
>> Simpler:
>>
>> if (ps_ret) {
>>      if (ret) {
>>        error_free_or_abort(errp);
>>      }
>>      ret = ps_ret;
>>      error_propagate(errp, local_err);
>> }
>>
> Will do.
>>> +    } else if (vmsd->post_save) {
>>>            int ps_ret = vmsd->post_save(opaque);
>>>            if (!ret && ps_ret) {
>>>                ret = ps_ret;
>>
>> When there is a preceding error, this code still returns it and dismisses
>> the post_save() error although the other part of this function is changed to
>> propagate the error of post-save unconditionally. Please keep them
>> consistent.
> 
> I do feel that in the new implementation (post_save_errp), we should be dismissing
> the preceeding error and propagating the new error from post_save().
> Because, that way, it makes sense to run the post_save_errp() part even after encountering
> an error in the preceeding section (vmstate_subsection_save).

What to propagate to the caller shouldn't matter when running the 
post_save_errp() because the behavior is for the caller and not for the 
internal implementation of this function.

There are two requirements for this function:
1. The proceeding error should be passed to the caller
2. The proceeding error should not prevent calling post_save_errp()

Let's assume whether the proceeding error is dismissed or not affects 
both post_save_errp() and the caller. Under this assumption,
- if the proceeding error is dismissed, it will violate condition 1.
- if the proceeding error is not dismissed, it will violate condition 2.

So it is more reasonable to think that we are defining different 
handling methods for the caller and post_save_errp().

If error propagation for the caller still has an implication on the 
condition to run post_save_errp(), it means the meanings of the 
proceeding error for post_save_errp() and the caller are "different but 
somehow correlated". It sounds convoluted and I don't have an idea of 
such correlation.

I don't think there is a common answer for what error to propagate when 
there are several errors, so I see three options:
- propagate whatever error easier to do so
- somehow combine errors
   (languages that support exceptions often do this)
- make sure that no error will happen when there is a proceeding error
   by having two callbacks:
   - One callback that is called only when there is no proceeding error
     and can raise an error
   - Another that is always called but cannot raise an error

> 
> Not sure if I should change the old impl post_save to match post_save_errp,
> Or should I match the new impl with the old one.

The reasoning you provided applies for post_save() too, so I think they 
should have a consistent behavior if you stick to it.

That change is also better to be split into its own patch; by splitting 
it, you can ensure that, if this series causes a regression for TPM, 
bisect will tell what led to the regression: the return value 
propagation change or the addition of errp.

Regards,
Akihiko Odaki

