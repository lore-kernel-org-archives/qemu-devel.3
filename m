Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E99C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 18:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfNcA-0004B4-Kj; Tue, 04 Feb 2025 13:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tfNc0-000493-3C
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:25:28 -0500
Received: from vps-ovh.mhejs.net ([145.239.82.108])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tfNby-0002t8-0g
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 13:25:27 -0500
Received: from MUA
 by vps-ovh.mhejs.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (Exim 4.98) (envelope-from <mhej@vps-ovh.mhejs.net>)
 id 1tfNbp-00000006rUh-31Ls; Tue, 04 Feb 2025 19:25:17 +0100
Message-ID: <150a9741-daab-4724-add0-f35257e862f9@maciej.szmigiero.name>
Date: Tue, 4 Feb 2025 19:25:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/33] io: tls: Allow terminating the TLS session
 gracefully with EOF
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1738171076.git.maciej.szmigiero@oracle.com>
 <fdd9a0a6053ac6aed32e08cc284991a3630bbfec.1738171076.git.maciej.szmigiero@oracle.com>
 <Z6IvAXXfIgDRYV5o@redhat.com>
 <493dd3bc-8a3d-4b3c-8eea-08e674c38f40@maciej.szmigiero.name>
 <Z6I86e-hzJAlxk0r@redhat.com>
Content-Language: en-US, pl-PL
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Autocrypt: addr=mail@maciej.szmigiero.name; keydata=
 xsFNBFpGusUBEADXUMM2t7y9sHhI79+2QUnDdpauIBjZDukPZArwD+sDlx5P+jxaZ13XjUQc
 6oJdk+jpvKiyzlbKqlDtw/Y2Ob24tg1g/zvkHn8AVUwX+ZWWewSZ0vcwp7u/LvA+w2nJbIL1
 N0/QUUdmxfkWTHhNqgkNX5hEmYqhwUPozFR0zblfD/6+XFR7VM9yT0fZPLqYLNOmGfqAXlxY
 m8nWmi+lxkd/PYqQQwOq6GQwxjRFEvSc09m/YPYo9hxh7a6s8hAP88YOf2PD8oBB1r5E7KGb
 Fv10Qss4CU/3zaiyRTExWwOJnTQdzSbtnM3S8/ZO/sL0FY/b4VLtlZzERAraxHdnPn8GgxYk
 oPtAqoyf52RkCabL9dsXPWYQjkwG8WEUPScHDy8Uoo6imQujshG23A99iPuXcWc/5ld9mIo/
 Ee7kN50MOXwS4vCJSv0cMkVhh77CmGUv5++E/rPcbXPLTPeRVy6SHgdDhIj7elmx2Lgo0cyh
 uyxyBKSuzPvb61nh5EKAGL7kPqflNw7LJkInzHqKHDNu57rVuCHEx4yxcKNB4pdE2SgyPxs9
 9W7Cz0q2Hd7Yu8GOXvMfQfrBiEV4q4PzidUtV6sLqVq0RMK7LEi0RiZpthwxz0IUFwRw2KS/
 9Kgs9LmOXYimodrV0pMxpVqcyTepmDSoWzyXNP2NL1+GuQtaTQARAQABzTBNYWNpZWogUy4g
 U3ptaWdpZXJvIDxtYWlsQG1hY2llai5zem1pZ2llcm8ubmFtZT7CwZQEEwEIAD4CGwMFCwkI
 BwIGFQoJCAsCBBYCAwECHgECF4AWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZdEV4gUJDWuO
 nQAKCRCEf143kM4JdyzED/0Qwk2KVsyNwEukYK2zbJPHp7CRbXcpCApgocVwtmdabAubtHej
 7owLq89ibmkKT0gJxc6OfJJeo/PWTJ/Qo/+db48Y7y03Xl+rTbFyzsoTyZgdR21FQGdgNRG9
 3ACPDpZ0UlEwA4VdGT+HKfu0X8pVb0G0D44DjIeHC7lBRzzE5JXJUGUVUd2FiyUqMFqZ8xP3
 wp53ekB5p5OstceqyZIq+O/r1pTgGErZ1No80JrnVC/psJpmMpw1Q56t88JMaHIe+Gcnm8fB
 k3LyWNr7gUwVOus8TbkP3TOx/BdS/DqkjN3GvXauhVXfGsasmHHWEFBE0ijNZi/tD63ZILRY
 wUpRVRU2F0UqI+cJvbeG3c+RZ7jqMAAZj8NB8w6iviX1XG3amlbJgiyElxap6Za1SQ3hfTWf
 c6gYzgaNOFRh77PQbzP9BcAVDeinOqXg2IkjWQ89o0YVFKXiaDHKw7VVld3kz2FQMI8PGfyn
 zg5vyd9id1ykISCQQUQ4Nw49tqYoSomLdmIgPSfXDDMOvoDoENWDXPiMGOgDS2KbqRNYCNy5
 KGQngJZNuDicDBs4r/FGt9/xg2uf8M5lU5b8vC78075c4DWiKgdqaIhqhSC+n+qcHX0bAl1L
 me9DMNm0NtsVw+mk65d7cwxHmYXKEGgzBcbVMa5C+Yevv+0GPkkwccIvps7AzQRaRrwiAQwA
 xnVmJqeP9VUTISps+WbyYFYlMFfIurl7tzK74bc67KUBp+PHuDP9p4ZcJUGC3UZJP85/GlUV
 dE1NairYWEJQUB7bpogTuzMI825QXIB9z842HwWfP2RW5eDtJMeujzJeFaUpmeTG9snzaYxY
 N3r0TDKj5dZwSIThIMQpsmhH2zylkT0jH7kBPxb8IkCQ1c6wgKITwoHFjTIO0B75U7bBNSDp
 XUaUDvd6T3xd1Fz57ujAvKHrZfWtaNSGwLmUYQAcFvrKDGPB5Z3ggkiTtkmW3OCQbnIxGJJw
 /+HefYhB5/kCcpKUQ2RYcYgCZ0/WcES1xU5dnNe4i0a5gsOFSOYCpNCfTHttVxKxZZTQ/rxj
 XwTuToXmTI4Nehn96t25DHZ0t9L9UEJ0yxH2y8Av4rtf75K2yAXFZa8dHnQgCkyjA/gs0ujG
 wD+Gs7dYQxP4i+rLhwBWD3mawJxLxY0vGwkG7k7npqanlsWlATHpOdqBMUiAR22hs02FikAo
 iXNgWTy7ABEBAAHCwXwEGAEIACYCGwwWIQRyeg1N257Z9gOb7O+Ef143kM4JdwUCZdEWBwUJ
 DWuNXAAKCRCEf143kM4Jd5OdD/0UXMpMd4eDWvtBBQkoOcz2SqsWwMj+vKPJS0BZ33MV/wXT
 PaTbzAFy23/JXbyBPcb0qgILCmoimBNiXDzYBfcwIoc9ycNwCMBBN47Jxwb8ES5ukFutjS4q
 +tPcjbPYu+hc9qzodl1vjAhaWjgqY6IzDGe4BAmM+L6UUID4Vr46PPN02bpm4UsL31J6X+lA
 Vj5WbY501vKMvTAiF1dg7RkHPX7ZVa0u7BPLjBLqu6NixNkpSRts8L9G4QDpIGVO7sOC9oOU
 2h99VYY1qKml0qJ9SdTwtDj+Yxz+BqW7O4nHLsc4FEIjILjwF71ZKY/dlTWDEwDl5AJR7bhy
 HXomkWae2nBTzmWgIf9fJ2ghuCIjdKKwOFkDbFUkSs8HjrWymvMM22PHLTTGFx+0QbjOstEh
 9i56FZj3DoOEfVKvoyurU86/4sxjIbyhqL6ZiTzuZAmB0RICOIGilm5x03ESkDztiuCtQL2u
 xNT833IQSNqyuEnxG9/M82yYa+9ClBiRKM2JyvgnBEbiWA15rAQkOqZGJfFJ3bmTFePx4R/I
 ZVehUxCRY5IS1FLe16tymf9lCASrPXnkO2+hkHpBCwt75wnccS3DwtIGqwagVVmciCxAFg9E
 WZ4dI5B0IUziKtBxgwJG4xY5rp7WbzywjCeaaKubtcLQ9bSBkkK4U8Fu58g6Hg==
In-Reply-To: <Z6I86e-hzJAlxk0r@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.239.82.108;
 envelope-from=mhej@vps-ovh.mhejs.net; helo=vps-ovh.mhejs.net
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.07, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4.02.2025 17:14, Daniel P. Berrangé wrote:
> On Tue, Feb 04, 2025 at 05:02:23PM +0100, Maciej S. Szmigiero wrote:
>> On 4.02.2025 16:15, Daniel P. Berrangé wrote:
>>> On Thu, Jan 30, 2025 at 11:08:28AM +0100, Maciej S. Szmigiero wrote:
>>>> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>>>>
>>>> Currently, hitting EOF on receive without sender terminating the TLS
>>>> session properly causes the TLS channel to return an error (unless
>>>> the channel was already shut down for read).
>>>>
>>>> Add an optional setting whether we instead just return EOF in that
>>>> case.
>>>>
>>>> This possibility will be soon used by the migration multifd code.
>>>>
>>>> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>>>> ---
>>>>    include/io/channel-tls.h | 11 +++++++++++
>>>>    io/channel-tls.c         |  6 ++++++
>>>>    2 files changed, 17 insertions(+)
>>>>
>>>> diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
>>>> index 26c67f17e2d3..8552c0d0266e 100644
>>>> --- a/include/io/channel-tls.h
>>>> +++ b/include/io/channel-tls.h
>>>> @@ -49,6 +49,7 @@ struct QIOChannelTLS {
>>>>        QCryptoTLSSession *session;
>>>>        QIOChannelShutdown shutdown;
>>>>        guint hs_ioc_tag;
>>>> +    bool premature_eof_okay;
>>>>    };
>>>>    /**
>>>> @@ -143,4 +144,14 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
>>>>    QCryptoTLSSession *
>>>>    qio_channel_tls_get_session(QIOChannelTLS *ioc);
>>>> +/**
>>>> + * qio_channel_tls_set_premature_eof_okay:
>>>> + * @ioc: the TLS channel object
>>>> + *
>>>> + * Sets whether receiving an EOF without terminating the TLS session properly
>>>> + * by used the other side is considered okay or an error (the
>>>> + * default behaviour).
>>>> + */
>>>> +void qio_channel_tls_set_premature_eof_okay(QIOChannelTLS *ioc, bool enabled);
>>>> +
>>>>    #endif /* QIO_CHANNEL_TLS_H */
>>>> diff --git a/io/channel-tls.c b/io/channel-tls.c
>>>> index aab630e5ae32..1079d6d10de1 100644
>>>> --- a/io/channel-tls.c
>>>> +++ b/io/channel-tls.c
>>>> @@ -147,6 +147,11 @@ qio_channel_tls_new_client(QIOChannel *master,
>>>>        return NULL;
>>>>    }
>>>> +void qio_channel_tls_set_premature_eof_okay(QIOChannelTLS *ioc, bool enabled)
>>>> +{
>>>> +    ioc->premature_eof_okay = enabled;
>>>> +}
>>>> +
>>>>    struct QIOChannelTLSData {
>>>>        QIOTask *task;
>>>>        GMainContext *context;
>>>> @@ -279,6 +284,7 @@ static ssize_t qio_channel_tls_readv(QIOChannel *ioc,
>>>>                tioc->session,
>>>>                iov[i].iov_base,
>>>>                iov[i].iov_len,
>>>> +            tioc->premature_eof_okay ||
>>>>                qatomic_load_acquire(&tioc->shutdown) & QIO_CHANNEL_SHUTDOWN_READ,
>>>>                errp);
>>>>            if (ret == QCRYPTO_TLS_SESSION_ERR_BLOCK) {
>>>
>>> IMHO a better way to do this is by defining an new flag for use with
>>> the qio_channel_readv_full() method. That makes the ignoring of
>>> premature shutdown a contextually scoped behaviour rather than a
>>> global behaviour.
>>
>> Something named like QIO_CHANNEL_READ_FLAG_TLS_EARLY_EOF_OKAY?
> 
> Since the flags are defined at the non-TLS layer in the API, I would
> pick  "QIO_CHANNEL_READ_RELAXED_EOF", as it could conceptually make
> sense to other layered channel protocols beyond TLS, even if we only
> ever implement it for TLS.

This will need extending at least qio_channel_read_all_eof(),
qio_channel_readv_all_eof() and qio_channel_readv_full_all_eof() with
"flags" parameter (and patching their callers accordingly) since they
currently don't take such parameter.

That's for the multifd channel recv thread main loop only, if @Peter
wants to patch also the mid-stream page receive methods and the main
migration channel receive then qio_channel_read(), qio_channel_read_all(),
qio_channel_readv_all() and qio_channel_readv_full_all() would need
such treatment too.
Not sure whether this makes sense since we should never get premature
TLS session termination mid-stream (and if we do get on that would be
a genuine error AFAIK).

> With regards,
> Daniel

Thanks,
Maciej


